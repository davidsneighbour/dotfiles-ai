#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "$0")"
AI_ROOT="${HOME}/.ai"
HELPERS_DIR="${HOME}/.dotfiles/bashrc/helpers"

CATEGORIES=("agents" "instructions" "prompts" "skills" "resources")

usage() {
  cat <<USAGE
Usage: ${SCRIPT_NAME} [command] [--force]

Commands:
  setup     Create ~/.ai -> current repo symlink and install this script into ~/.dotfiles/bashrc/helpers
  link      Open interactive linker (default). Requires an existing .vscode directory unless --force is provided
  status    Show linked and unlinked AI files by category
  help      Show this help

Options:
  --force   Create .vscode if it does not exist when running the link command
USAGE
}

print_error() {
  local message="$1"
  if command -v gum >/dev/null 2>&1; then
    gum style --foreground 196 "${message}"
  else
    printf '%s\n' "${message}" >&2
  fi
}

require_gum() {
  if ! command -v gum >/dev/null 2>&1; then
    printf 'gum is required. Install from: https://github.com/charmbracelet/gum\n' >&2
    exit 1
  fi
}

replace_target_with_symlink() {
  local source="$1"
  local target="$2"

  if [[ -e "${target}" || -L "${target}" ]]; then
    rm -rf "${target}"
  fi

  ln -s "${source}" "${target}"
}

ensure_ai_root() {
  local repo_root
  repo_root="$(pwd)"

  if [[ -L "${AI_ROOT}" ]]; then
    local current_target
    current_target="$(readlink "${AI_ROOT}")"
    if [[ "${current_target}" != "${repo_root}" ]]; then
      gum style --foreground 214 "${AI_ROOT} currently points to ${current_target}"
      if gum confirm "Re-point ${AI_ROOT} to ${repo_root}?"; then
        replace_target_with_symlink "${repo_root}" "${AI_ROOT}"
      fi
    fi
  elif [[ -e "${AI_ROOT}" ]]; then
    gum style --foreground 196 "${AI_ROOT} exists and is not a symlink. Please move it first."
    exit 1
  else
    ln -s "${repo_root}" "${AI_ROOT}"
    gum style --foreground 42 "Created ${AI_ROOT} -> ${repo_root}"
  fi
}

require_ai_root_linked() {
  if [[ ! -L "${AI_ROOT}" ]]; then
    print_error "${AI_ROOT} needs to be linked before using this script. Run: ${SCRIPT_NAME} setup"
    exit 1
  fi
}

ensure_vscode_target() {
  local force_create="$1"

  if [[ -d ".vscode" ]]; then
    return
  fi

  if [[ "${force_create}" == "true" ]]; then
    mkdir -p .vscode
    gum style --foreground 42 "Created .vscode because --force was provided"
    return
  fi

  gum style --foreground 196 ".vscode does not exist. Re-run with --force to create it."
  exit 1
}

install_helper_link() {
  mkdir -p "${HELPERS_DIR}"
  local target="${HELPERS_DIR}/${SCRIPT_NAME}"
  local source_path="${AI_ROOT}/scripts/${SCRIPT_NAME}"

  replace_target_with_symlink "${source_path}" "${target}"
  gum style --foreground 42 "Installed helper symlink: ${target} -> ${source_path}"
}

strip_display_name() {
  local filename="$1"
  filename="${filename%.prompt.md}"
  filename="${filename%.agent.md}"
  filename="${filename%.chatmode.md}"
  filename="${filename%.instruction.md}"
  filename="${filename%.md}"
  filename="${filename%.*}"
  printf '%s' "${filename}"
}

link_all_items_in_category() {
  local category="$1"
  local source="${AI_ROOT}/${category}"
  local target_dir=".vscode/${category}"

  if [[ ! -d "${source}" ]]; then
    gum style --foreground 214 "Skipping ${category}: ${source} not found"
    return
  fi

  local entries=()
  mapfile -t entries < <(build_entries "${source}" | sort)

  if ((${#entries[@]} == 0)); then
    gum style --foreground 214 "Skipping ${category}: no items in ${source}"
    return
  fi

  mkdir -p "${target_dir}"

  local line name base
  for line in "${entries[@]}"; do
    name="${line%%$'\t'*}"
    base="${line#*$'\t'}"

    replace_target_with_symlink "${source}/${base}" "${target_dir}/${name}"
    gum style --foreground 42 "Linked ${target_dir}/${name} -> ${source}/${base}"
  done
}

pick_category() {
  gum choose "${CATEGORIES[@]}"
}

build_entries() {
  local source_dir="$1"
  local path base name

  for path in "${source_dir}"/*; do
    [[ -e "${path}" ]] || continue

    if [[ -f "${path}" || -d "${path}" ]]; then
      base="$(basename "${path}")"
      name="$(strip_display_name "${base}")"
      printf '%s\t%s\n' "${name}" "${base}"
    fi
  done
}

is_item_linked() {
  local category="$1"
  local base="$2"
  local name
  name="$(strip_display_name "${base}")"

  local source="${AI_ROOT}/${category}/${base}"
  local target_dir=".vscode/${category}"
  local target="${target_dir}/${name}"

  if [[ -L "${target}" ]]; then
    local item_target
    item_target="$(readlink "${target}")"
    [[ "${item_target}" == "${source}" ]]
    return
  fi

  return 1
}

show_status() {
  require_ai_root_linked

  local any_linked="false"
  local category source_dir entries line base name

  printf 'AI link status for %s\n\n' "$(pwd)/.vscode"

  for category in "${CATEGORIES[@]}"; do
    source_dir="${AI_ROOT}/${category}"
    printf '%s:\n' "${category}"

    if [[ ! -d "${source_dir}" ]]; then
      printf '  linked:\n'
      printf '    (none)\n'
      printf '  unlinked:\n'
      printf '    (category missing in ~/.ai)\n\n'
      continue
    fi

    mapfile -t entries < <(build_entries "${source_dir}" | sort)

    if ((${#entries[@]} == 0)); then
      printf '  linked:\n'
      printf '    (none)\n'
      printf '  unlinked:\n'
      printf '    (no files)\n\n'
      continue
    fi

    local linked=()
    local unlinked=()

    for line in "${entries[@]}"; do
      base="${line#*$'\t'}"
      name="${line%%$'\t'*}"
      if is_item_linked "${category}" "${base}"; then
        linked+=("${name}")
        any_linked="true"
      else
        unlinked+=("${name}")
      fi
    done

    printf '  linked:\n'
    if ((${#linked[@]} == 0)); then
      printf '    (none)\n'
    else
      printf '    - %s\n' "${linked[@]}"
    fi

    printf '  unlinked:\n'
    if ((${#unlinked[@]} == 0)); then
      printf '    (none)\n'
    else
      printf '    - %s\n' "${unlinked[@]}"
    fi

    printf '\n'
  done

  if [[ "${any_linked}" == "false" ]]; then
    printf 'No AI files are currently linked.\n'
  fi
}

link_individual_files() {
  local category
  category="$(pick_category)"

  local source_dir="${AI_ROOT}/${category}"
  if [[ ! -d "${source_dir}" ]]; then
    gum style --foreground 214 "${source_dir} not found"
    return
  fi

  local entries=()
  mapfile -t entries < <(build_entries "${source_dir}" | sort)

  if ((${#entries[@]} == 0)); then
    gum style --foreground 214 "No items in ${source_dir}"
    return
  fi

  local selected=()
  mapfile -t selected < <(printf '%s\n' "${entries[@]}" | gum choose --no-limit --header "Select ${category} items to symlink")

  if ((${#selected[@]} == 0)); then
    gum style --foreground 214 "No items selected"
    return
  fi

  mkdir -p ".vscode/${category}"

  local line name base
  for line in "${selected[@]}"; do
    name="${line%%$'\t'*}"
    base="${line#*$'\t'}"

    replace_target_with_symlink "${source_dir}/${base}" ".vscode/${category}/${name}"
    gum style --foreground 42 "Linked .vscode/${category}/${name} -> ${source_dir}/${base}"
  done
}

interactive_link() {
  local force_create="${1:-false}"

  require_gum
  require_ai_root_linked
  ensure_vscode_target "${force_create}"

  gum style --border rounded --padding '0 1' --margin '1 0' \
    "AI linker" \
    "Source: ${AI_ROOT}" \
    "Target: $(pwd)/.vscode"

  local action
  action="$(gum choose \
    "Link all items in all categories" \
    "Link all items in one category" \
    "Link individual items")"

  case "${action}" in
  "Link all items in all categories")
    local category
    for category in "${CATEGORIES[@]}"; do
      link_all_items_in_category "${category}"
    done
    ;;
  "Link all items in one category")
    link_all_items_in_category "$(pick_category)"
    ;;
  "Link individual items")
    link_individual_files
    ;;
  esac
}

run_setup() {
  require_gum
  ensure_ai_root
  install_helper_link
  gum style --foreground 42 "Setup complete"
}

main() {
  local command="${1:-link}"
  local force_create="false"

  if [[ "${2:-}" == "--force" ]]; then
    force_create="true"
  elif [[ "${1:-}" == "--force" ]]; then
    command="link"
    force_create="true"
  fi

  case "${command}" in
  setup)
    run_setup
    ;;
  link)
    interactive_link "${force_create}"
    ;;
  status)
    show_status
    ;;
  help | -h | --help)
    usage
    ;;
  *)
    usage
    exit 1
    ;;
  esac
}

main "$@"

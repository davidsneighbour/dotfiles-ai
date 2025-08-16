Write a Bash file that executes actions to recreate a development environment for me.

## General instructions

* WE = this Bash script
* THEY = the user running the script
* if the script needs to run `sudo` then ask for the password for each individual step that requires `sudo` and clear the password after execution. Make it clear that WE are asking for the root password to execute a specific script (print the script instead of executing it). Do not use `sudo` if they are not required (for instance to install Docker)
* all Git activity is done via `git@github.com:user/repo.git` notation (SSH)

## Repositories

All repositories are hosted on GitHub under the username `davidsneighbour` and are public, unless indicated in this list via `(private)`

* dotfiles
* dotfiles-protected (private)
* dotfiles-plugin-bash-github-scripts
* dotfiles-plugin-bash-rofi-scripts
* dotfiles-containers
* dotfiles-containers-protected (private)

## CLI config parameters to configure

* `--user` - username (github.com/username/reponame), default davidsneighbour
* `--repo` - reponame for dotfiles main repository (github.com/username/reponame), default dotfiles

## Steps to execute

* ensure that `nvm`, `docker-compose` and `git` are installed. if not, install the tools
  * git installation

    ```bash
    sudo apt install git
    ```

  * for `nvm` and `docker-compose` tell THEM to re-run the script after installation
* check if the current directory contains a clone of `dotfiles` and
  * either clone the repository into the current directory using `git clone --recurse-submodules` to load all submodules from .gitmodules
  * or checkout the main branch and pull all updates

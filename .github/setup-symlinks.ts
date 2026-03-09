import fs from 'node:fs/promises';
import path from 'node:path';

interface Config {
  mainRepoRoot: string;
  targetPath: string;
  linkPath: string;
}

const config: Config = {
  // Adjust if you move the script:
  mainRepoRoot: process.cwd(),
  // Where your private repo lives:
  targetPath: path.resolve(
    process.env.COPAILOT_REPO_PATH ?? '~/github.com/davidsneighbour/copailot',
  ),
  // Where the link should be inside the main repo:
  linkPath: path.resolve(process.cwd(), '.github/instructions'),
};

/**
 * Expand '~' to the user's home directory in a path-like string.
 */
function expandHome(p: string): string {
  if (p.startsWith('~/')) {
    const home = process.env.HOME;
    if (!home) {
      throw new Error('HOME environment variable is not set.');
    }
    return path.join(home, p.slice(2));
  }
  return p;
}

async function ensureSymlink(cfg: Config): Promise<void> {
  const target = expandHome(cfg.targetPath);
  const link = cfg.linkPath;

  try {
    const stat = await fs.stat(target);
    if (!stat.isDirectory()) {
      throw new Error(`Target path is not a directory: ${target}`);
    }
  } catch (error) {
    console.error('[setup-instructions-link] Target directory missing or invalid.');
    console.error(`[setup-instructions-link] Expected at: ${target}`);
    console.error(error);
    process.exitCode = 1;
    return;
  }

  try {
    const existing = await fs.lstat(link).catch(() => undefined);

    if (existing) {
      if (existing.isSymbolicLink()) {
        const currentTarget = await fs.readlink(link);
        if (path.resolve(path.dirname(link), currentTarget) === target) {
          console.log('[setup-instructions-link] Symlink already correct.');
          return;
        }

        console.log('[setup-instructions-link] Updating existing symlink.');
        await fs.unlink(link);
      } else {
        console.error(
          `[setup-instructions-link] Path exists and is not a symlink: ${link}`,
        );
        process.exitCode = 1;
        return;
      }
    } else {
      // Ensure parent directory exists
      await fs.mkdir(path.dirname(link), { recursive: true });
    }

    await fs.symlink(target, link);
    console.log(
      `[setup-instructions-link] Created symlink: ${link} -> ${target}`,
    );
  } catch (error) {
    console.error('[setup-instructions-link] Failed to create symlink.');
    console.error(error);
    process.exitCode = 1;
  }
}

void ensureSymlink(config);

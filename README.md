# My dotfiles

I am using [GNU Stow](https://www.gnu.org/software/stow/) to symlink
my dotfiles to their correct locations in my `$HOME` directory.

## Installing `stow`

### Ubuntu/Debian

```bash
apt install stow
```

### Fedora/RHEL

```bash
dnf install stow
```

### Arch

```bash
pacman -S stow
```

### MacOS

```bash
brew install stow
```

## Cloning this repo

```bash
git clone https://github.com/eric-bixby/dotfiles.git
```

## Using `stow`

### Installing all symlinks

```bash
stow -t "$HOME" -S */
```

### Uninstalling all symlinks

```bash
stow -t "$HOME" -D */
```

### Repairing all symlinks

```bash
stow -t "$HOME" -R */
```

### Installing specific dotfiles

```bash
stow -t "$HOME" -S git
```

## Verification

If there are no errors, everything in that directory should be symlinked.
Check by doing a quick `ls -al ~/`

---

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

## Troubleshooting `stow`

### Issue: Get the following error when uninstalling or reparing

```bash
BUG in find_stowed_path? Absolute/relative mismatch between Stow dir <PWD> and path <SYMLINK_PATH> at /usr/local/Cellar/stow/2.3.1//Library/Perl/5.30/Stow.pm line 966, <DATA> line 22.
```

### Workaround: Ignore or remove existing symlinks in target folder

---

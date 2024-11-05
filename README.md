This directory contains the dotfiles necessary for my workflow

### Requirements

Ensure you have the following packages are install on your system

#### Git

```sh
apt install git
```

#### Stow

```sh
apt install stow
```

### Installation

#### Stow

Clone the dotfiles repository to your `$HOME` directory

```sh
git clone git@github.com:nobilissimum/dotfiles.git
cd dotfiles
```

Use `stow` command to create the symbolic links. Use the `--no-folding` flag to prevent symbolic links for directories - this would make sure to create symlinks for individual files. The `--adopt` flag allows conflicts in the stow directory and home directory.

```sh
stow --no-folding --adopt .
```

Source `.zshrc_/.sh` in your shell rc file.

```sh
ZSHRC_DIR="$HOME/.zshrc_"
source "$ZSHRC_DIR/.sh"
```

#### Alacritty

Create `alacritty.toml` inside `.config/alacritty` directory to import `nobilissimum.toml` configuration and your preferred [hush theme](https://github.com/nobilissimum/hush-alacritty) configuration.

```toml
# alacritty.toml

import = [
  "$HOME/.config/alacritty/tenshiro.toml",
  "$HOME/.config/alacritty/hush.toml",
]
```

#### Nix

Nix is installed using the **[Determinate Nix installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#install-determinate)**.

To get started, open a new shell or run

```sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

Install specified packages in `home.nix` by running

```sh
nix run home-manager switch
```

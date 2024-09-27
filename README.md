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

Use `stow` command to create the symbolic links

```sh
stow .
```

Alternatively, the following command can be used. This will force resolve conflicting files but will overwrite your stow directory.

```sh
stow --adopt .
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

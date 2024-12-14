This directory contains the dotfiles necessary for my workflow

### Requirements

Ensure you have the following packages are install on your system

- curl - for [determinate nix](#nix) _(recommended)_
- git
- stow _(deprecated)_

### Setup

#### Nix

Clone the dotfiles repository to your `$HOME` directory

```sh
git clone git@github.com:nobilissimum/dotfiles.git
cd dotfiles
```

Nix is installed using the **[Determinate Nix installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#install-determinate)**.

To get started, open a new shell or run

```sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

Install specified packages in `home.nix` by running. You may not use the flag `-b backup` for the succeeding switches after the initial switch.

```sh
nix run home-manager -- switch --flake ./home-manager/#linux --impure -b backup
```

Append `zsh` executable filepath to `/etc/shells` then set it as the default shell.

```sh
command -v zsh | sudo tee -a /etc/shells
chsh nobi -s $(which zsh)
```

### Environment

#### WSL

When using WSL, `systemd` should be enabled and `wsl` should be updated. Append the following to `/etc/wsl.conf`

```
[boot]
systemd=true
```

Run the following command in PowerShell

```sh
wsl --update
```

### Tools

#### Alacritty

Create `alacritty.toml` inside `.config/alacritty` directory to import `nobilissimum.toml` configuration and your preferred [hush theme](https://github.com/nobilissimum/hush-alacritty) configuration.

```toml
# alacritty.toml

import = [
  "$HOME/.config/alacritty/tenshiro.toml",
  "$HOME/.config/alacritty/hush.toml",
]
```

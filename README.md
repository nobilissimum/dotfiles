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

#### Secure Shell

Create SSH key. This would be used for **GitHub** and **SSH** connections.

```sh
# Templates
ssh-keygen -t ed25519 -C "<email>"
ssh-keygen -t rsa -b 4096 -C "<email>"

# Samples
ssh-keygen -t ed25519 -C "ronn.angelo.lee@gmail.com"
ssh-keygen -t rsa -b 4096 -C "ronn.angelo.lee@gmail.com"
```

Register the **SSH key** to online tools using SSH connections such as **GitHub**. The value of keys are usually stored in files with `.pub` extension in directory `~/.ssh`.

```sh
cat ~/.ssh/id_ed25519.pub
```

#### GNU Privacy Guard

Greate **GPG key**.

```sh
gpg [--expert] --full-generate-key
```

Get key ID by listing the secret keys.

```sh
gpg --list-secret-keys --keyid-format=long
```

In this sample output, `BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB` is key.

```
sec   ed25519/AAAAAAAAAAAAAAAA 2024-12-14 [SC]
      BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
uid                 [ultimate] Ronn Angelo Lee <ronn.angelo.lee@gmail.com>
ssb   cv25519/CCCCCCCCCCCCCCCC 2024-12-14 [E]
```

Initialize **GNU Pass** with the new created GPG key.

```sh
pass init BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
```

Register the **GPG key** to online tools that use GPG key for authentication such as **GitHub** and **Docker Hub**.

```sh
gpg --armor --export <email>
```

#### Git

Configure git to use **GPG key** when creating commits for signing.

```sh
git config --global user.signingkey <key>
git config --global commit.gpgsign true
```

#### Docker

Use **GNU Pass** for credentials by adding this to `~/.docker/config.json`. This will make Docker use the GPG key for authentication (ex: when running command `docker login`).

```json
{
    "credStore": "pass"
}
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

#### Shell

Custom commands you want to run on shell startup should be put in `~/.shrc/custom.sh`.

#### Alacritty

Create `alacritty.toml` inside `.config/alacritty` directory to import `nobilissimum.toml` configuration and your preferred [hush theme](https://github.com/nobilissimum/hush-alacritty) configuration.

```toml
# alacritty.toml

import = [
  "$HOME/.config/alacritty/tenshiro.toml",
  "$HOME/.config/alacritty/hush.toml",
]
```

#### Wezterm

The Wezterm configuration is enabled by default. If there's a need to reconfigure Wezterm (in cases such as WSL wherein you have to specify the Linux distro), you can do so by returning a function in a new file `~/.config/wezterm/wezterm-custom.lua`.

```lua
local custom_config = function(config)
    config.default_prog = { "C:\\Windows\\System32\\wsl.exe", "-d", "openSUSE-Tumbleweed", "--cd", "~" }
    return config
end

return custom_config
```

{ config, pkgs, ... }:

let
    sessionVariables = {
        EDITOR = "vim";
        FZF_HOME = "${pkgs.fzf}";
        ZSH_HOME = "${pkgs.zsh}";
    };
in
{
    home = {
        username = builtins.getEnv("USER");
        homeDirectory = builtins.getEnv("HOME");
        stateVersion = "24.05";

        activation = {
            dotfiles = config.lib.dag.entryAfter ["writeBoundary"] ''
                target="$HOME/.gnupg/gpg-agent.conf"
                if [ -e "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.gnupg/gpg-agent.conf" "$target"


                target="$HOME/.shrc"
                if [ -e "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.shrc" "$target"


                target="$HOME/.ssh/config"
                if [ -e "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.ssh/config" "$target"


                target="$HOME/.zshrc"
                if [ -e "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.zshrc" "$target"


                target="$HOME/.config/btop"
                if [ -d "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.config/btop" "$target"


                target="$HOME/.config/lazygit"
                if [ -d "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.config/lazygit" "$target"


                target="$HOME/.config/lf"
                if [ -d "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.config/lf" "$target"


                target="$HOME/.config/nvim"
                if [ -d "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.config/nvim" "$target"


                target="$HOME/.config/starship.toml"
                if [ -e "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.config/starship.toml" "$target"


                target="$HOME/.config/wezterm"
                if [ -d "$target" ]; then
                    rm -rf "$target"
                fi
                ln -sfn "$HOME/dotfiles/.config/wezterm" "$target"
            '';
        };

        packages = [
            pkgs.ascii-image-converter
            pkgs.btop
            pkgs.cl
            pkgs.deno
            pkgs.eza
            pkgs.fd
            pkgs.fzf
            pkgs.gcc
            pkgs.gnumake
            pkgs.gnupg
            pkgs.htop
            pkgs.jq
            pkgs.libgcc
            pkgs.libclang
            pkgs.lf
            pkgs.luajit
            pkgs.luajitPackages.luarocks
            pkgs.p7zip
            pkgs.pinentry-curses
            pkgs.nodejs_22
            pkgs.pass
            pkgs.pnpm
            pkgs.python312
            pkgs.ripgrep
            pkgs.starship
            pkgs.tree-sitter
            pkgs.unzip
            pkgs.wget
            pkgs.xclip
            pkgs.zig
            pkgs.zip
            pkgs.zoxide

            pkgs.lazygit
            pkgs.vim

            (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

            (pkgs.writeShellScriptBin "tmx-nix" ''
                 session_name="$(basename $(dirname $(pwd)) | sed 's/\./-/g')-$(basename $(pwd) | sed 's/\./-/g')"
                 if ! tmux a -t $session_name $COMMAND &> /dev/null; then
                     tmux new-session -d -s "$session_name"
                     tmux new-window -d
                     tmux new-window -d
                     tmux new-window -d
                     tmux attach-session -d -t "$session_name"
                     fi
                 '')
        ];

        sessionVariables = sessionVariables;
    };

    programs = {
        home-manager = {
            enable = true;
        };

        neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
        };

        tmux = {
            enable = true;
            terminal = "tmux-256color";
            extraConfig = ''
                set -g focus-events on
                set -g escape-time 0
                '';
            plugins = with pkgs; [
                {
                    plugin = tmuxPlugins.catppuccin;
                    extraConfig = ''
                        set -ga terminal-overrides ",xterm*:Tc"
                        set -ga terminal-overrides ",tmux-256color:RGB"

                        setw -g mode-keys vi
                    '';
                }
                tmuxPlugins.sensible
                tmuxPlugins.vim-tmux-navigator
            ];
        };

        # Shells
        bash = {
            enable = true;
            initExtra = "source ~/dotfiles/.bashrc";
            sessionVariables = sessionVariables;
        };
        zsh = {
            enable = true;
            initExtra = "source $HOME/dotfiles/.zshrc";
            sessionVariables = sessionVariables;
        };
    };
}

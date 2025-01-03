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

        file = {
            ".config/btop" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/btop";
                force = true;
            };
            ".config/lazygit" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/lazygit";
                force = true;
            };
            ".config/lf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/lf";
                force = true;
            };
            ".config/nvim" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim";
                force = true;
            };
            ".config/starship.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/starship.toml";
                force = true;
            };
            ".config/wezterm" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/wezterm";
                force = true;
            };

            ".gnupg/gpg-agent.conf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.gnupg/gpg-agent.conf";
                force = true;
            };
            ".shrc" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.shrc";
                force = true;
            };
            ".ssh/config" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.ssh/config";
                force = true;
            };
            ".zshrc" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.zshrc";
                force = true;
            };
        };

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
                        bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
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
            sessionVariables = sessionVariables;
        };
    };
}

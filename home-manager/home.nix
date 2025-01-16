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

                        set -g @catppuccin_window_left_separator "█"
                        set -g @catppuccin_window_middle_separator " •"
                        set -g @catppuccin_window_right_separator "█"
                        set -g @catppuccin_window_default_text " #{pane_current_command}"
                        set -g @catppuccin_window_current_text " #[bold]#{pane_current_command}"

                        set -g @catppuccin_pane_left_separator "█"
                        set -g @catppuccin_pane_middle_separator "█"
                        set -g @catppuccin_pane_right_separator "█"

                        set -g @catppuccin_status_left_separator "█"
                        set -g @catppuccin_status_middle_separator "█"
                        set -g @catppuccin_status_right_separator "█"

                        set -g @catppuccin_status_connect_separator "no"

                        set -g @catppuccin_status_modules_left "session  "
                        set -g @catppuccin_status_modules_right " "

                        set -g @thm_rosewater "#f77172"
                        set -g @thm_flamingo "#f77172"
                        set -g @thm_rosewater "#f77172"
                        set -g @thm_pink "#f77172"
                        set -g @thm_mauve "#f77172"
                        set -g @thm_red "#f77172"
                        set -g @thm_maroon "#f77172"
                        set -g @thm_peach "#cec999"
                        set -g @thm_yellow "#cec999"
                        set -g @thm_green "#65a884"
                        set -g @thm_teal "#2d949f"
                        set -g @thm_sky "#74add2"
                        set -g @thm_sapphire "#2d949f"
                        set -g @thm_blue "#74add2"
                        set -g @thm_lavender "#a980c4"

                        set -g @catppuccin_window_current_color "#65a884"
                        set -g @catppuccin_window_current_background "#1f2a35"
                        set -g @catppuccin_window_current_fill "all"
                        set -g @catppuccin_window_default_color "#393c4d"
                        set -g @catppuccin_window_default_background "#cdd6f4"
                        set -g @catppuccin_window_default_fill "all"

                        set -g @catppuccin_session_color "#{?client_prefix,#cec999,#74add2}"

                        set -g @catppuccin_status_background "#1f2a35"

                        set -g @thm_surface_0 "#393c4d"
                        set -g @thm_bg "#1f2a35"

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

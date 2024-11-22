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
            pkgs.cl
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
            pkgs.lua
            pkgs.luajitPackages.luarocks
            pkgs.p7zip
            pkgs.nodejs_22
            pkgs.pass
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
            ".bashrc" = {
                source = ~/dotfiles/.bashrc;
                force = true;
            };
            ".zshrc".source = ~/dotfiles/.zshrc;
            ".shrc" = {
                source = ~/dotfiles/.shrc;
                recursive = true;
                force = true;
            };
            ".p10k.zsh".source = ~/dotfiles/.p10k.zsh;
            ".config/lazygit" = {
                source = ~/dotfiles/.config/lazygit;
                recursive = true;
                force = true;
            };
            ".config/lf" = {
                source = ~/dotfiles/.config/lf;
                recursive = true;
                force = true;
            };
            ".config/nvim" = {
                source = ~/dotfiles/.config/nvim;
                recursive = true;
                executable = true;
                force = true;
                onChange = ''
                    chmod -R u+w $HOME/.config/nvim
                    '';
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
                    '';
            }
            tmuxPlugins.sensible
                tmuxPlugins.vim-tmux-navigator
            ];
        };

        # Shells
        bash = {
            enable = true;
            sessionVariables = sessionVariables;
        };
        zsh = {
            enable = true;
            sessionVariables = sessionVariables;
        };
    };
}

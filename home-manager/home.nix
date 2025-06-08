{ config, pkgs, ... }:

let
    sessionVariables = {
        EDITOR = "vim";

        FZF_HOME = "${pkgs.fzf}";
        LIBEVENT_HOME = "${pkgs.libevent}";
        LIBEVENT_DEV = "${pkgs.libevent.dev}";
        NCURSES_HOME = "${pkgs.ncurses}";
        NCURSES_DEV = "${pkgs.ncurses.dev}";
        ZSH_HOME = "${pkgs.zsh}";

        CC = "${pkgs.gcc}/bin/gcc";
        CXX = "${pkgs.gcc}/bin/g++";
        YACC = "${pkgs.bison}/bin/yacc";

        PKG_CONFIG_PATH = "${pkgs.libevent.dev}/lib/pkgconfig:${pkgs.ncurses.dev}/lib/pkgconfig:$PKG_CONFIG_PATH";
    };
in
{
    home = {
        username = builtins.getEnv("USER");
        homeDirectory = builtins.getEnv("HOME");
        stateVersion = "24.05";

        activation = {
            tpm = config.lib.dag.entryAfter ["writeBoundary"] ''
                [[ -d ~/.tmux-plugins/tpm ]] && rm -rf ~/.tmux/plugins/tpm
                ${pkgs.git}/bin/git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &> /dev/null 2>&1
            '';
        };

        packages = [
            pkgs.ascii-image-converter
            pkgs.bison
            pkgs.btop
            pkgs.cl
            pkgs.deno
            pkgs.eza
            pkgs.fd
            pkgs.fzf
            pkgs.gawk
            pkgs.gcc
            pkgs.gh
            pkgs.gh-dash
            pkgs.glibc
            pkgs.gnumake
            pkgs.gnupg
            pkgs.gnutar
            pkgs.gzip
            pkgs.htop
            pkgs.hurl
            pkgs.jq
            pkgs.lf
            pkgs.libclang
            pkgs.libevent
            pkgs.libevent.dev
            pkgs.libgcc
            pkgs.luajit
            pkgs.luajitPackages.luarocks
            pkgs.ncurses
            pkgs.ncurses.dev
            pkgs.nodejs_22
            pkgs.oha
            pkgs.p7zip
            pkgs.pass
            pkgs.pinentry-curses
            pkgs.pnpm
            pkgs.python312
            pkgs.ripgrep
            pkgs.starship
            pkgs.superfile
            pkgs.tree-sitter
            pkgs.unzip
            pkgs.wget
            pkgs.xclip
            pkgs.zig
            pkgs.zip
            pkgs.zoxide

            pkgs.lazygit
            pkgs.vim

            (pkgs.tmux.overrideAttrs (_: {
                version = "3.5a";
                src =   pkgs.fetchurl {
                    url = "https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz";
                    hash = "sha256-FiFr0IdxcN/MZBVwhbqQE2ELErCCVIx8lULMAQMZiVE=";
                };
            }))

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

            ".scripts" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.scripts";
                force = true;
            };
            ".shrc" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.shrc";
                force = true;
            };

            ".gnupg/gpg-agent.conf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.gnupg/gpg-agent.conf";
                force = true;
            };
            ".ssh/config" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.ssh/config";
                force = true;
            };
            ".tmux.conf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.tmux.conf";
                force = true;
            };
            ".zshrc" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.zshrc";
                force = true;
            };

            "neovim.png" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/neovim.png";
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

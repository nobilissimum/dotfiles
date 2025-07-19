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

    xdgConfigHome =
        let env = builtins.getEnv("XDG_CONFIG_HOME");
        in if env != "" then env else "${config.home.homeDirectory}/.config";

    dotfilesHome =
        let env = builtins.getEnv("DOTFILES_HOME");
        in if env != "" then env else "${config.home.homeDirectory}/dotfiles";
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
            pkgs.bison
            pkgs.deno
            pkgs.fd
            pkgs.gawk
            pkgs.gcc
            pkgs.gh
            pkgs.gh-dash
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
            pkgs.luajit
            pkgs.luajitPackages.luarocks
            pkgs.ncurses
            pkgs.ncurses.dev
            pkgs.nodejs_22
            pkgs.p7zip
            pkgs.pass
            pkgs.pinentry-curses
            pkgs.pnpm
            pkgs.python312
            pkgs.ripgrep
            pkgs.tree-sitter
            pkgs.unzip
            pkgs.wget
            pkgs.xclip
            pkgs.zig
            pkgs.zip

            # Credentials
            pkgs.docker-credential-helpers

            # CLI helpers
            pkgs.ascii-image-converter
            pkgs.btop
            pkgs.eza
            pkgs.fzf
            pkgs.oha
            pkgs.starship
            pkgs.zoxide

            # Rust
            pkgs.rustc
            pkgs.cargo

            # Neovim dependencies
            pkgs.nixpkgs-fmt
            pkgs.sql-formatter

            # Coding
            pkgs.lazygit
            pkgs.vim

            (pkgs.tmux.overrideAttrs (_: {
                version = "3.5a";
                src =   pkgs.fetchurl {
                    url = "https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz";
                    hash = "sha256-FiFr0IdxcN/MZBVwhbqQE2ELErCCVIx8lULMAQMZiVE=";
                };
            }))

            # (pkgs.nerdfonts.override { fonts = [ "GeistMono" ]; })

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
            "${xdgConfigHome}/btop" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/btop";
                force = true;
            };
            "${xdgConfigHome}/lazygit" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/lazygit";
                force = true;
            };
            "${xdgConfigHome}/lf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/lf";
                force = true;
            };
            "${xdgConfigHome}/nvim" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/nvim";
                force = true;
            };
            "${xdgConfigHome}/starship.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/starship.toml";
                force = true;
            };

            "${xdgConfigHome}/ghostty" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/ghostty";
                force = true;
            };
            "${xdgConfigHome}/wezterm" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/wezterm";
                force = true;
            };

            "${xdgConfigHome}/superfile/config.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/config.toml";
                force = true;
            };
            "${xdgConfigHome}/superfile/hotkeys.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/hotkeys.toml";
                force = true;
            };
            "${xdgConfigHome}/superfile/themes/hush.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/themes/hush.toml";
                force = true;
            };

            ".docker/config.json" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.docker/config.json";
                force = true;
            };
            "containers/auth.json" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.docker/config.json";
                force = true;
            };

            ".scripts" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.scripts";
                force = true;
            };
            ".shrc" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.shrc";
                force = true;
            };

            ".ssh/config" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.ssh/config";
                force = true;
            };
            ".tmux.conf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.tmux.conf";
                force = true;
            };
            ".zshrc" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.zshrc";
                force = true;
            };

            "neovim.png" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/neovim.png";
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

        zsh = {
            enable = true;
            sessionVariables = sessionVariables;
        };
    };
}

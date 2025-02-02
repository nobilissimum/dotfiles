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
            tmux = config.lib.dag.entryAfter ["writeBoundary"] ''
                export CC=${pkgs.gcc}/bin/gcc
                export CXX=${pkgs.gcc}/bin/g++
                # export YACC="${pkgs.bison}/bin/yacc"

                export PATH="${pkgs.bison}/bin:${pkgs.gawk}/bin:${pkgs.gnumake}/bin:$PATH"

                ${pkgs.wget}/bin/wget https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
                ${pkgs.gzip}/bin/gunzip -c tmux-3.5a.tar.gz | ${pkgs.gnutar}/bin/tar xf -

                cd tmux-3.5a
                ./configure \
                    --prefix="$HOME/.local" \
                    LDFLAGS="-L${pkgs.libevent}/lib -L${pkgs.ncurses}/lib" \
                    CFLAGS="-I${pkgs.libevent.dev}/include -I${pkgs.ncurses.dev}/include"
                make
                make install

                cd ..
                rm -rf tmux-3.5a
                rm tmux-3.5a.tar.gz
            '';
            tpm = config.lib.dag.entryAfter ["writeBoundary"] ''
                rm -rf ~/.tmux/plugins/tpm
                ${pkgs.git}/bin/git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
            pkgs.gnumake
            pkgs.gnupg
            pkgs.gnutar
            pkgs.gzip
            pkgs.htop
            pkgs.jq
            pkgs.libclang
            pkgs.libevent
            pkgs.libevent.dev
            pkgs.libgcc
            pkgs.lf
            pkgs.luajit
            pkgs.luajitPackages.luarocks
            pkgs.oha
            pkgs.p7zip
            pkgs.pinentry-curses
            pkgs.ncurses
            pkgs.ncurses.dev
            pkgs.nodejs_22
            pkgs.pass
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
            ".tmux.conf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.tmux.conf";
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

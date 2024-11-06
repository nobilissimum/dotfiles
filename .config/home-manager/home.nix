{ config, pkgs, ... }:

{
  home = {
    username = "tenshiro";
    homeDirectory = "/home/tenshiro";
    stateVersion = "24.05";

    packages = [
      pkgs.cowsay
      pkgs.lazygit
      pkgs.vim

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      (pkgs.writeShellScriptBin "tmx" ''
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
      ".zshrc_".source = ~/dotfiles/.zshrc_;
      ".p10k.zsh".source = ~/dotfiles/.p10k.zsh;

      ".config/lazygit".source = ~/dotfiles/.config/lazygit;
      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs = {
    home-manager = {
      enable = true;
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

    zsh = {
      enable = true;
      initExtra = ''
        source ~/.zshrc_/.sh
      '';
    };
  };
}

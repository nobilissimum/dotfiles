{ config, pkgs, ... }:

{
  home = {
    username = "tenshiro";
    homeDirectory = "/home/tenshiro";
    stateVersion = "24.05";

    packages = [
      pkgs.cowsay
      pkgs.lazygit

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

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
  };
}

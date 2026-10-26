{ config, pkgs, pkgs-unstable, ... }:

let
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

        packages = [
            pkgs.cl
            pkgs.glibc
            pkgs.libgcc

            pkgs-unstable.superfile
        ];

        file = {
            "${xdgConfigHome}/superfile/config.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/config.toml";
                force = true;
            };
            "${xdgConfigHome}/superfile/hotkeys.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/hotkeys.toml";
                force = true;
            };
            "${xdgConfigHome}/superfile/theme/hush.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/theme/hush.toml";
                force = true;
            };

        };
    };

    programs = {
        bash = {
            enable = true;
            initExtra = "source ~/dotfiles/.bashrc";
        };
    };
}

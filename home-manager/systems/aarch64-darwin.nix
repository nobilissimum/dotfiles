{ config, pkgs, ... }:

let
    homeDirectory = builtins.getEnv("HOME");
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
            pkgs.superfile
        ];

        file = {
            "${homeDirectory}/Library/Application Support/superfile/config.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/config.toml";
                force = true;
            };
            "${homeDirectory}/Library/Application Support/superfile/hotkeys.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/hotkeys.toml";
                force = true;
            };
            "${homeDirectory}/Library/Application Support/superfile/themes/hush.toml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${dotfilesHome}/.config/superfile/themes/hush.toml";
                force = true;
            };
        };
    };
}

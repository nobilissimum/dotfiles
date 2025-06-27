{ pkgs, ... }:

{
    home = {
        username = builtins.getEnv("USER");
        homeDirectory = builtins.getEnv("HOME");
        stateVersion = "24.05";

        packages = [
            pkgs.cl
            pkgs.glibc
            pkgs.libgcc
            pkgs.superfile
        ];
    };

    programs = {
        bash = {
            enable = true;
            initExtra = "source ~/dotfiles/.bashrc";
        };
    };
}

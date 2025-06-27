{ }:

{
    home = {
        username = builtins.getEnv("USER");
        homeDirectory = builtins.getEnv("HOME");
        stateVersion = "24.05";
    };
}

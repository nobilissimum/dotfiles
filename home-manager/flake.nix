{
    description = "Home Manager configuration";

    inputs = {
        fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*";
        # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.*";
        home-manager = {
            # url = "github:nix-community/home-manager/release-25.05";
            url = "https://flakehub.com/f/nix-community/home-manager/0.2505.*";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }:
    let
        system = builtins.currentSystem;
        pkgs = nixpkgs.legacyPackages.${system};
    in {

        homeConfigurations."nobi" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ]
                ++ (pkgs.lib.optionals (pkgs.stdenv.system == "x86_64-linux") [ ./systems/x86_64-linux.nix ])
                ++ (pkgs.lib.optionals (pkgs.stdenv.system == "aarch64-darwin") [ ./systems/aarch64-darwin.nix ])
            ;
        };
    };
}

{
    description = "Home Manager configuration";

    inputs = {
        fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*";
        nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2605.*";  # github:nixos/nixpkgs/nixos-26.05
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "https://flakehub.com/f/nix-community/home-manager/0.2605.*";  # github:nix-community/home-manager/release-26.05
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
        system = builtins.currentSystem;
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
        homeConfigurations."nobi" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit pkgs-unstable; };
            modules = [ ./home.nix ]
                ++ (pkgs.lib.optionals (pkgs.stdenv.system == "x86_64-linux") [ ./systems/x86_64-linux.nix ])
                ++ (pkgs.lib.optionals (pkgs.stdenv.system == "aarch64-darwin") [ ./systems/aarch64-darwin.nix ])
            ;
        };
    };
}

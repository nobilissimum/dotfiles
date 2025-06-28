{
    description = "Home Manager configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
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
                ++ [ ./systems/${pkgs.stdenv.system}.nix ]

                # ++ (pkgs.lib.optionals (pkgs.stdenv.system == "x86_64-linux") [ ./systems/x86_64-linux.nix ])
                # ++ (pkgs.lib.optionals (pkgs.stdenv.system == "x86_64-darwin") [ ./systems/x86_64-darwin.nix ])
            ;
        };
    };
}

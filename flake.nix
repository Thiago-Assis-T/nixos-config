{
  description = "NixOS Desktop Config:";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hosts = {
      url = "file+http://sbc.io/hosts/alternates/fakenews-gambling-porn/hosts";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, unstable, hosts, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = ["electron-19.1.9" "nix-2.15.3" ];
        };
      };

      unstable-pkgs = import unstable {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "nix-2.15.3" ];
        };
      };

    in {

      nixosConfigurations = {
       
        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hosts system pkgs unstable-pkgs; };

          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system pkgs unstable-pkgs;
                };
                users.thiago = import ./home;
              };
            }
          ];
        };
      };

    };
}

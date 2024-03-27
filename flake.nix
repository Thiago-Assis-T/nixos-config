{
  description = "NixOS Desktop Config:";

  inputs = {

    dwl-src = {
      url = "git+https://codeberg.org/ThiagoAssis/dwl?ref=personalMain";
      flake = false;
    };

    slstatus-src = {
      url = "git+https://codeberg.org/ThiagoAssis/slstatus.git";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";

    hosts = {
      url = "file+http://sbc.io/hosts/alternates/fakenews-gambling-porn/hosts";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, home-manager, nixpkgs, hosts, dwl-src, slstatus-src, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

    in {

      nixosConfigurations = {

        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hosts system pkgs dwl-src slstatus-src; };

          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system pkgs dwl-src slstatus-src;
                };
                users.thiago = import ./home;
              };
            }
          ];
        };
      };

    };
}

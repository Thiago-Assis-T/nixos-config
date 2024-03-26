{
  description = "NixOS Desktop Config:";

  inputs = {

    dwl = {
      url = "git+https://codeberg.org/dwl/dwl?ref=main";
      flake = false;
    };

    slstatus = {
      url = "git+https://git.suckless.org/slstatus?ref=master";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11-small";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";

    hosts = {
      url = "file+http://sbc.io/hosts/alternates/fakenews-gambling-porn/hosts";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, unstable, hosts, dwl, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "nix-2.15.3" ];
        };
      };

      unstable-pkgs = import unstable {
        inherit system;
        config = { allowUnfree = true; };
      };

    in {

      nixosConfigurations = {

        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hosts system pkgs unstable-pkgs dwl; };

          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system pkgs unstable-pkgs dwl;
                };
                users.thiago = import ./home;
              };
            }
          ];
        };
      };

    };
}

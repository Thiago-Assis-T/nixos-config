{
  description = "NixOS Desktop Config:";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hosts = {
      url = "file+http://sbc.io/hosts/alternates/fakenews-gambling-porn/hosts";
      flake = false;
    };

    dwl-src = {
      url = "git+https://codeberg.org/ThiagoAssis/dwl?ref=personalMain";
      flake = false;
    };

    slstatus-src = {
      url = "git+https://codeberg.org/ThiagoAssis/slstatus.git";
      flake = false;
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xplr-tree-view = {
      url = "git+https://github.com/sayanarijit/tree-view.xplr?ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, hosts, dwl-src, slstatus-src
    , xplr-tree-view, nixvim, ... }:
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
            ./hosts/ThiagoDesktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system pkgs xplr-tree-view;
                };
                users.thiago = import ./home;
              };
            }
          ];
        };
      };

    };
}

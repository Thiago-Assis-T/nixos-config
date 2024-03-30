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

    xplr-tree-view = {
      url = "git+https://github.com/sayanarijit/tree-view.xplr?ref=main";
      flake = false;

    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, hosts, dwl-src, slstatus-src
    , xplr-tree-view, ... }:
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

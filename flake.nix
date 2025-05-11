{
  description = "Nix Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nixvim,
    darwin,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        formatter = pkgs.alejandra;
      }
    )
    // {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jie = import ./home-manager/shared.nix;
            }
          ];
        };
      };

      darwinConfigurations = {
        macbook = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jie = import ./home-manager/shared.nix;
            }
          ];
        };
      };

      homeConfigurations = let
        mkServerConfig = username: homeDir:
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {system = "x86_64-linux";};
            modules = [
              ./home.nix
            ];
            extraSpecialArgs = {
              inherit username homeDir;
            };
          };
      in {
        cc = mkServerConfig "cc" "/home/cc";
        goku = mkServerConfig "jiezzz" "/zp_goku/scratch_sb/jiezzz";
        vegeta = mkServerConfig "jiezzz" "/zp_vegeta/scratch_sb/jiezzz";
      };
    };
}

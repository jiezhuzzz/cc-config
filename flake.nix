{
  description = "Nix Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
    home-manager,
    nixvim,
    darwin,
    ...
  }: let
    makeServerConfig = server:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          nixvim.homeManagerModules.nixvim
          ./servers/${server}.nix
          ./home.nix
        ];
      };
    servers = ["cc" "goku" "vegeta"];
  in {
    homeConfigurations = nixpkgs.lib.genAttrs servers (server: makeServerConfig server);
    darwinConfigurations."mac" = darwin.lib.darwinSystem {
      modules = [
        ./darwin
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jie = ./home.nix;
        }
      ];
    };
    # formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}

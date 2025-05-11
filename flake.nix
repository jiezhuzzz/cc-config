{
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
  }: let
    # Common functions
    mkNixosConfig = username: homeDir:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home-manager/nixos.nix;
          }
        ];
      };

    mkDarwinConfig = username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          {
            users.users.${username} = {
              name = username;
              home = "/Users/${username}";
            };
            nix.settings.trusted-users = [
              "root"
              "@admin"
              username
            ];
            system.stateVersion = 6;
            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
          ./darwin
          nixvim.nixDarwinModules.nixvim
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home-manager/darwin.nix;
          }
        ];
      };

    mkServerConfig = username: homeDir:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [
          ./home-manager/shared.nix
        ];
        extraSpecialArgs = {
          inherit username homeDir;
        };
      };
  in
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        formatter = pkgs.alejandra;
      }
    )
    // {
      nixosConfigurations = {
        steamer = mkNixosConfig "jie" "/home/jie";
      };

      darwinConfigurations = {
        mac = mkDarwinConfig "jie";
      };

      homeConfigurations = {
        cc = mkServerConfig "cc" "/home/cc";
        goku = mkServerConfig "jiezzz" "/zp_goku/scratch_sb/jiezzz";
        vegeta = mkServerConfig "jiezzz" "/zp_vegeta/scratch_sb/jiezzz";
      };
    };
}

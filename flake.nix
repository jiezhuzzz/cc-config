{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    opnix.url = "github:brizzbuzz/opnix";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    catppuccin,
    vscode-server,
    nix-homebrew,
    home-manager,
    nix4vscode,
    darwin,
    disko,
    opnix,
    ...
  }: let
    # Common functions
    mkDesktopConfig = username:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit username catppuccin;
        };
        modules = [
          ./desktop
          catppuccin.nixosModules.catppuccin
          disko.nixosModules.disko
          vscode-server.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
      };

    mkNasConfig = username:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            users.users.${username} = {
              isNormalUser = true;
              extraGroups = [
                "wheel"
                "networkmanager"
                "video"
                "audio"
              ];
              shell = nixpkgs.legacyPackages.x86_64-linux.zsh;
              openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxEzB8rb/S0bPaTymoXEj0OFj7FXy2XTapYXLJBMBkj"
              ];
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username}.imports = [
              catppuccin.homeModules.catppuccin
              ./home-manager/nas.nix
            ];
          }
          ./nas
          catppuccin.nixosModules.catppuccin
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
        ];
      };

    mkDarwinConfig = username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          {
            nixpkgs.overlays = [
              nix4vscode.overlays.default
            ];
            nixpkgs.config.allowUnfree = true;
            users.users.${username} = {
              name = username;
              home = "/Users/${username}";
            };
            nix.settings.trusted-users = [
              "root"
              "@admin"
              username
            ];
            system.primaryUser = username;
            system.stateVersion = 6;
            system.configurationRevision = self.rev or self.dirtyRev or null;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.overwriteBackup = true;
            home-manager.backupFileExtension = "old";
            home-manager.users.${username}.imports = [
              opnix.homeManagerModules.default
              catppuccin.homeModules.catppuccin
              ./home-manager/darwin.nix
            ];
            nix-homebrew = {
              enable = true;
              user = username;
              autoMigrate = true;
            };
          }
          ./darwin
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
      };

    mkServerConfig = username: homeDir:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [
          opnix.homeManagerModules.default
          catppuccin.homeModules.catppuccin
          ./home-manager/server.nix
        ];
        extraSpecialArgs = {
          inherit username homeDir;
        };
      };

    mkCodespaceConfig = username: homeDir:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [
          catppuccin.homeModules.catppuccin
          ./home-manager/codespace.nix
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
        steamer = mkDesktopConfig "jie";
        nas = mkNasConfig "nas";
      };

      darwinConfigurations = {
        mac = mkDarwinConfig "jie";
      };

      homeConfigurations = {
        space = mkCodespaceConfig "vscode" "/home/vscode";
        cc = mkServerConfig "cc" "/home/cc";
        orb = mkServerConfig "jie" "/home/jie";
        goku = mkServerConfig "jiezzz" "/zp_goku/scratch_sb/jiezzz";
        vegeta = mkServerConfig "jiezzz" "/zp_vegeta/scratch_sb/jiezzz";
      };
    };
}

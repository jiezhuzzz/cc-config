{
  self,
  pkgs,
  ...
}
: {
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jie = {
    imports = [../home.nix];
    home.homeDirectory = "/Users/jie";
    home.username = "jie";
  };
}

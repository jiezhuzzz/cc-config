{
  all = {
    imports = [
      ./immich.nix
      ./plex.nix
      ./kavita.nix
      ./transmission.nix
    ];
  };

  immich = ./immich.nix;
  plex = ./plex.nix;
  kavita = ./kavita.nix;
  transmission = ./transmission.nix;
}

{
  services.colima = {
    enable = true;
    profiles = {
      darwin = {
        #isActive = true;
        #isService = true;
        settings = {
          cpu = 4;
          memory = 16;
          arch = "x86_64";
          vmType = "vz";
          rosetta = true;
        };
      };
    };
  };
}

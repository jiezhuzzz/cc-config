{
  services.espanso = {
    enable = true;
    matches = {
      latex = {
        matches = [
          {
            trigger = ";m";
            replace = "\\($|$\\)";
          }
        ];
      };
      global_vars = {
        global_vars = [
          {
            name = "currentdate";
            type = "date";
            params = {format = "%d/%m/%Y";};
          }
          {
            name = "currenttime";
            type = "date";
            params = {format = "%R";};
          }
        ];
      };
    };
  };
}

{
  programs.fish = {
    enable = true;
    shellInit = ''
      # Load environment variables from ~/.envs
      if test -f ~/.envs
        for line in (cat ~/.envs | grep -v '^#' | grep -v '^$')
          set -gx (string split -m 1 '=' $line)
        end
      end
    '';
  };
}

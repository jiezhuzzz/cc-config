{pkgs, ...}: {
  programs.gh = {
    enable = true;
    # hosts = {
    #   "github.com" = {
    #     username = "jiezzz";
    #   };
    # };
    extensions = with pkgs; [
      gh-dash
      gh-poi
      gh-eco
      gh-s
      gh-f
    ];
    # settings = {
    #   git_protocol = "ssh";
    # };
  };
}

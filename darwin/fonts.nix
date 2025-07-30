{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    maple-mono.NF-unhinted
    mona-sans
    hubot-sans
  ];
}

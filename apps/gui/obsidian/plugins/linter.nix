{
  pkgs,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "obsidian-linter";
  version = "unstable";
  src = pkgs.fetchFromGitHub {
    owner = "platers";
    repo = "obsidian-linter";
    rev = "main";
    sha256 = lib.fakeSha256;
  };

  # 将源码原样放到 $out，确保 manifest.json 在输出根目录
  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
}

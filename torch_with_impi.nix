{
  pkgs ? import <nixpkgs> { }
}:

pkgs.dockerTools.buildImage {
  name = "torch-with-impi";
  tag = "latest";

  fromImage = pkgs.dockerTools.pullImage {
              imageName = "wangyinz/nix_test_impi";
              imageDigest = "sha256:4d4f3ae7755700152b1e2982d5208b5eaf385176a4f956fc531db587dd788b8a";
              sha256 = "sha256-bsdmcglYypqw1HaA3Vg1d4HZvXa+V0WOgqOhLj+n9YI=";
              os = "linux";
              arch = "x86_64";
            };


  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [
      pkgs.bash
      pkgs.coreutils
      (pkgs.python312.withPackages (ps: with ps; [ torch torchvision ]))
    ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    Cmd = [ "/bin/bash" ];
  };
}

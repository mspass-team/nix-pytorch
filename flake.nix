{
  description = "PyTorch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    shell-utils.url = "github:waltermoreira/shell-utils";
    hpcKit-utils.url = "github:Nixify-Technology/intel-mpi-nix";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , shell-utils
    , hpcKit-utils
    }:

      with flake-utils.lib; eachSystem [
        system.x86_64-linux
      ]
        (system:
        let
          pkgs = import nixpkgs { inherit system; };
          oneapi-version = "2021.10.0";
          shell = shell-utils.myShell.${system};
          hpcKit = hpcKit-utils.packages.${system}.default;
        in
        {
          devShells.default = shell {
            name = "PyTorch";
            packages = [
              hpcKit
              pkgs.mpich
              pkgs.cudaPackages.cudnn
              # replace `torch` with `torchWithCuda` for a CUDA version
              (pkgs.python311.withPackages (ps: with ps; [ torch torchvision ]))
            ];
          };
        });
}
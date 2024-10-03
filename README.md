# nix-pytorch

## Usage

```
nix-build torch_with_impi.nix && docker load < result
docker run -it torch-with-impi:latest bash
```

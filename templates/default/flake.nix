{
  description = "Default pwnnix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pwndbg.url = "github:pwndbg/pwndbg";
  };

  outputs = inputs@{ flake-parts, pwndbg, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = { pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            # Tools used for common CTF platforms
            netcat-gnu
            wireguard-tools
            socat

            # Debuggers/Dissasemblers
            gef
            gdb
            radare2
            ghidra-bin

            # Tools
            python313Packages.ropper
            checksec
            pwntools
            pwndbg.packages.${system}.pwndbg
          ];
        };
      };
    };
}

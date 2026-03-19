{
  description = "Nix flake with common utilities for Pwn and binary explotation CTF challenges";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      flake.templates.default = {
        path = ./templates/default;
        description = "Default pwnnix template";
      };
    };
}

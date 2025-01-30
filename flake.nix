{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    cargo-v5.url = "github:vexide/cargo-v5";
  };

  outputs = { nixpkgs, flake-utils, cargo-v5, ... }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cargo-v5' = cargo-v5.packages.${system}.default;
      in {
        devShell =
          pkgs.mkShell { buildInputs = [ pkgs.gcc-arm-embedded cargo-v5' ]; };
      }));
}

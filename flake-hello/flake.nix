{
  description = "A simple flake to test Nix installation";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/25.11";

  outputs = { self, nixpkgs }: {
    packages = {
      x86_64-linux = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in {

        # Custom hello.c package
        HelloFlake = pkgs.stdenv.mkDerivation {
          pname = "HelloFlakePName";
          version = "1.0";

          src = ./src;

          buildInputs = [ pkgs.gcc ];

          buildPhase = ''
            gcc -o hello-flake hello.c
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp hello-flake $out/bin/
          '';
        };

        # Add Wayland utilities
        Weston = pkgs.weston;
      };
    };
  };
}
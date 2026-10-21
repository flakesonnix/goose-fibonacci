{
  description = "Fibonacci in Goose";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    goose.url = "github:aardappel/goose";
    goose.flake = false;
  };

  outputs = { self, nixpkgs, goose }@inputs: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    checks."x86_64-linux".default = pkgs.runCommand "goose-fibonacci" {
      src = ./.;
      buildInputs = [ pkgs.cmake pkgs.gcc ];
    } ''
      export HOME=$(mktemp -d)
      cp -r $src/* .
      cmake -B build -S ${goose}
      cmake --build build -j
      ./build/goose build fib.goose
      ./build/goose build test_fib.goose
      mkdir -p $out/bin
      cp fib $out/bin/
      cp test_fib $out/bin/
      ./fib
      ./test_fib
    '';

    packages.x86_64-linux.default = pkgs.runCommand "goose-fibonacci-bin" {
      src = ./.;
      buildInputs = [ pkgs.cmake pkgs.gcc ];
    } ''
      export HOME=$(mktemp -d)
      cp -r $src/* .
      cmake -B build -S ${goose}
      cmake --build build -j
      ./build/goose build fib.goose
      ./build/goose build test_fib.goose
      mkdir -p $out/bin
      cp fib $out/bin/
      cp test_fib $out/bin/
    '';
  };
}

{
  description = "Fibonacci in Goose";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    goose.url = "github:aardappel/goose";
  };

  outputs = { self, nixpkgs, goose }@inputs: {
    checks."x86_64-linux".build = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      goose-src = goose + "/";
    in pkgs.stdenv.mkDerivation {
      name = "goose-fibonacci-build";
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      buildPhase = ''
        cmake -B build -S ${goose-src}
        cmake --build build -j
        ./build/goose build fib.goose
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp fib $out/bin/
      '';
    };

    checks."x86_64-linux".test = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      goose-src = goose + "/";
    in pkgs.stdenv.mkDerivation {
      name = "goose-fibonacci-test";
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      buildPhase = ''
        cmake -B build -S ${goose-src}
        cmake --build build -j
        ./build/goose build fib.goose
        ./build/goose build test_fib.goose
        ./fib
        ./test_fib
      '';
      installPhase = ''
        true
      '';
    };

    devShells."x86_64-linux".default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      buildInputs = [ pkgs.cmake pkgs.gcc pkgs.git ];
      shellHook = ''
        echo "Entered goose-fibonacci development shell"
        echo "Build Goose compiler: cmake -B build -S <goose-repo> && cmake --build build -j"
        echo "Build fib.goose:      ./build/goose build fib.goose && ./fib"
        echo "Run unit tests:       ./build/goose build test_fib.goose && ./test_fib"
      '';
    };
  };
}

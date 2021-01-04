{ pkgs ? import <nixpkgs> {} }:

  pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.buildPackages.vim

        pkgs.buildPackages.gcc10
        pkgs.buildPackages.clang_11

        pkgs.buildPackages.clang-tools
        pkgs.buildPackages.clang-analyzer
        pkgs.buildPackages.valgrind
        pkgs.buildPackages.gdb

        pkgs.buildPackages.cmake 
      ];
  }

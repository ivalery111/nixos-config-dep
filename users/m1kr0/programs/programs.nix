{ pkgs, ... }:
{
  # m1kr0's user programs
  users.users.m1kr0.packages = with pkgs; [
        binutils-unwrapped
        git
        neovim
        gnumake
        cmake
        vscodium
        plank
        htop
        zip
        unzip
        minicom

        gcc10
        clang_11
        valgrind
        gdb

        python3

        firefox

        qemu
        virt-manager

        docker
        docker-compose

        transmission
        vlc
  ];
}


{ config, ... }:

{
  imports = [
    ./boot/uefi.nix
    ./environment/default.nix
    ./networking/default.nix
    ./xserver/default.nix
    ./openssh/default.nix
    ./printing/default.nix
    ./locale/default.nix
    ./sound/default.nix
    ./time/default.nix
    ./virt/default.nix
  ];
}


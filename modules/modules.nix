{ config, pkgs, ... }:

{
  imports = [
    ./boot/uefi.nix
    ./networking/networking.nix
    ./time/time.nix 
    ./locale/locale.nix
    ./console/console.nix
    ./sound/sound.nix
    ./virt/virt.nix
  ];
}


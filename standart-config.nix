{ config, pkgs, ... }:

{
  imports = [
    ./modules/modules.nix
    ./services/services.nix
  ];
}


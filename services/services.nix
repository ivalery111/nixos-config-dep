{ config, ... }:

{
  imports = [
    ./xserver/xserver.nix
    ./openssh/openssh.nix
    ./printing/printing.nix
  ];
}


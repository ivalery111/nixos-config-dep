{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      wget
      vim
      midori
  ];
}


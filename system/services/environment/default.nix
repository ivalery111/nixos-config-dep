{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      wget
      vim
      midori

      # For i3 to control brightness with fn
      xorg.xbacklight
  ];
}


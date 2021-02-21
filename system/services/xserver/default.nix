# TODO(valery): Split to the subodules like a display manager, desktop manager, ...
{ config, pkgs, callPackage, ... }:

{
  services.xserver = {
    enable = true;

    displayManager= {
      defaultSession = "none+i3";
    };

    desktopManager= {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };

    videoDrivers = [ "intel" ];

    layout = "us";
    xkbOptions = "eurosign:e";

    # Enable touchpad
    libinput ={
      enable = true;
      disableWhileTyping = true;
    };

  };
}


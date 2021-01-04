# TODO(valery): Split to the subodules like a display manager, desktop manager, ...

{
  services.xserver = {
    enable = true;

    displayManager.sddm = {
      enable = true;
    };

    desktopManager.plasma5 = {
      enable = true;
    };

    windowManager.i3 = {
      enable = true;
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


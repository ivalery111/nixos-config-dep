# TODO(valery): Split this module into the small submodules like a networkManager, firewall, ...

{ config, ...}:
{
  networking = {
  
    hostName = "home";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
    };

  };
}


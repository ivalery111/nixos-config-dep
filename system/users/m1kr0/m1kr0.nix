{ pkgs, ... }:
{

  users.users.m1kr0 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
}


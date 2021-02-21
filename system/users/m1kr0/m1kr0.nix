{ pkgs, ... }:
{

  users.users.m1kr0 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };
}


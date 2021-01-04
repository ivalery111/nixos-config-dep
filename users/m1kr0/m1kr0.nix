{
  imports = [
    ./programs/programs.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.m1kr0 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

}


{ config, lib, pkgs, stdenv, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/neovim/default.nix
    ./programs/fish/default.nix
  ];

  home.packages = [

    # Editors
    pkgs.vscodium

    # Video
    pkgs.vlc

    # Utils
    pkgs.unzip

    # Browsers
    pkgs.firefox
    pkgs.brave

    pkgs.tmux
    pkgs.ctags
   pkgs.alacritty
   pkgs.virt-manager
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "m1kr0";
  home.homeDirectory = "/home/m1kr0";

  programs.git = {
    enable = true;

    package = pkgs.gitAndTools.gitFull;

    userName = "Valery Ivanov";
    userEmail = "ivalery111@gmail.com";
  };

#  programs.neovim = {
#    enable = true;
#
#    vimAlias = true;
#
#    plugins = [
#      pkgs.vimPlugins.vim-nix
#      pkgs.vimPlugins.nerdtree
#    ];
#  };

  programs.ssh.enable = true;

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
      ];

      theme = "agnoster";
    };
  };

  programs.htop.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}

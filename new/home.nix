{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "valery";
  home.homeDirectory = "/home/valery";

  home.packages = with pkgs; [
    gnumake
    cmake
    conan
    qtcreator
    gcc
    gdb
    lldb
    ccls
    openvpn
    update-systemd-resolved
    transmission-gtk
    qemu
    virt-manager
    bear
  ];

  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      hookyqr.beautify
      xaver.clang-format
      redhat.vscode-yaml
      vadimcn.vscode-lldb
      donjayamanne.githistory
      ms-azuretools.vscode-docker
    ];
  };

  programs.i3status = {
    enable = true;
  };

  #
  # PROGRAMS
  #
	
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = "colorscheme gruvbox";
    plugins = with pkgs.vimPlugins; [
       vim-nix
       gruvbox
       coc-nvim
       coc-yank
       vim-lsp-cxx-highlight
    ];
  };

  programs.alacritty = {
    enable = true;
  };
  
  programs.git = {
    enable = true;
    userName = "Valery Ivanov";
    userEmail = "ivalery111@gmail.com";
  
    extraConfig = {
      core.editor = "vim";
    };
  };

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
 
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "clean";
    };


  };

  #
  # SERVICES
  #

  services.redshift = {
    enable = true;
    latitude = 55.7615902;
    longitude = 37.60946;
  };




  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}

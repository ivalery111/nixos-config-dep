# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let

sddm-clairvoyance = pkgs.stdenv.mkDerivation {
  name = "sddm-clairvoyance";
  version = "master-2019-05-30";

  src = pkgs.fetchFromGitHub {
    owner = "eayus";
    repo = "sddm-theme-clairvoyance";
    rev =    "dfc5984ff8f4a0049190da8c6173ba5667904487";
    sha256 = "13z78i6si799k3pdf2cvmplhv7n1wbpwlsp708nl6gmhdsj51i81";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/clairvoyance
    cp -r * $out/share/sddm/themes/clairvoyance
  '';

  meta = with lib; {
    description = "Sweeten the login experience for your users, your family and yourself.";
    homepage = "https://github.com/Kangie/sddm-sugar-candy";
    maintainers = with maintainers; [ ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    # fsType = "ext4";
    options = [ "nofail" ];
  };

  networking.networkmanager.enable = true;
  networking.hostName = "NIXOS"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.useDHCP = false;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.interfaces.enp0s20f0u6u1.useDHCP = true;
  # networking.interfaces.enp0s20f0u3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.useGlamor = true;
  
  #qt5.enable = true;
  #qt5.platformTheme = "gtk2";
  #qt5.style = "gtk2";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.sddm.theme = "breeze";
  services.xserver.displayManager.sddm.enableHidpi = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  programs.sway = {
    enable = true;
  wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      waybar
      autotiling
      wofi
      kanshi
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
  };
  

  # Configure keymap in X11
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "grp:alt_shift_toggle";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.valery = {
    isNormalUser = true;
    home = "/home/valery";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  firefox
  #  git
  #  brightnessctl
  #];
  #environment = {
  #  etc = {
  #    "sway/config".source = /home/valery/dotfiles/sway/config;
  #    "xdg/waybar/config".source = /home/valery/dotfiles/waybar/config;
  #    "xdg/waybar/style.css".source = /home/valery/dotfiles/waybar/style.css;
  #  };
  #};

  # Here we but a shell script into path, which lets us start sway.service (after importing the environment of the login shell).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    git
    brightnessctl
    gparted
    sddm-clairvoyance

    (
      pkgs.writeTextFile {
        name = "startsway";
        destination = "/bin/startsway";
        executable = true;
        text = ''
          #! ${pkgs.bash}/bin/bash

          # first import environment variables from the login manager
          systemctl --user import-environment
          # then start the service
          exec systemctl --user start sway.service
        '';
      }
    )
  ];

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  systemd.user.services.sway = {
    description = "Sway - Wayland window manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    # We explicitly unset PATH here, as we want it to be set by
    # systemctl --user import-environment in startsway
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  programs.waybar.enable = true;

  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      # kanshi doesn't have an option to specifiy config file yet, so it looks
      # at .config/kanshi/config
      ExecStart = ''
        ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

  fonts.fonts = [
    pkgs.dejavu_fonts
    pkgs.font-awesome
    #pkgs.Iosevka
    pkgs.font-awesome_5
    pkgs.nerdfonts
    pkgs.cantarell-fonts
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}


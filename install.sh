#! /usr/bin/env bash

# Print the output of every command
set +x

echo "[I]: Setting up the nix configuration"
echo "[I]: ..."

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.bak
sudo cp -u system/configuration.nix /etc/nixos/
sudo mkdir -p /etc/nixos/nixos-conf
sudo mkdir -p /etc/nixos/nixos-conf/services
sudo cp -ur system/services/* /etc/nixos/nixos-conf/services/

sudo mkdir -p /etc/nixos/nixos-conf/users
sudo cp -ur system/users/* /etc/nixos/nixos-conf/users/

echo "[I]: End of setting up the nix configuration"

echo "[I]: Setting up the Home Manager"
echo "[I]: ..."

sudo mkdir -p $HOME/.config/nixpkgs/
sudo cp -r home/* $HOME/.config/nixpkgs/
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
home-manager switch

echo "[I]: End of Setting up the Home Manager"

{ config, lib, pkgs, ... }:

let

  custom-plugins = pkgs.callPackage ./custom-plugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
  };

  plugins = pkgs.vimPlugins // custom-plugins;

  overriddenPlugins = with pkgs; [];

  personalVimPlugins = with plugins; [
    coc-nvim                # LSP client + autocompletion plugin
    coc-yank                # yank plugin for CoC
    lightline-vim           # configurable status line (can be used by coc)
    vim-hybrid-material
    neomake                 # run programs asynchronously and highlight errors
    nerdcommenter           # code commenter
    nerdtree                  # tree explorer
    nerdtree-git-latest
    vim-airline             # bottom status bar
    vim-airline-themes
    vim-easy-align          # alignment plugin
    vim-easymotion          # highlights keys to move quickly
    vim-fish                # fish shell highlighting
    vim-fugitive            # git plugin
    vim-nix                 # nix support (highlighting, etc)
    vim-tmux                # syntax highlighting for tmux conf file and more
    vim-gitgutter
    vim-clang-format
    # syntastic
    gruvbox
  ] ++ overriddenPlugins;

  baseConfig = builtins.readFile ./config.vim;
  cocConfig = builtins.readFile ./coc.vim;
  cocSettings   = builtins.toJSON (import ./coc-settings.nix);
  pluginsConfig = builtins.readFile ./plugins.vim;
  vimConfig = baseConfig + pluginsConfig + cocConfig;

in
{
    programs.neovim = {
      enable       = true;
      extraConfig  = vimConfig;
      plugins      = personalVimPlugins;
      viAlias      = true;
      vimAlias     = true;
      vimdiffAlias = true;
      withNodeJs   = true; # for coc.nvim
      withPython   = true; # for plugins
      withPython3  = true; # for plugins
    };
}


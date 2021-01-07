# Define your custom plugins

{ pkgs, lib, buildVimPlugin }:

{

# Example:

#   asyncrun-vim = buildVimPlugin {
#     name = "asyncrun-vim";
#     src = builtins.fetchTarball {
#       name   = "AsyncRun-Vim-v2.7.5";
#       url    = "https://github.com/skywind3000/asyncrun.vim/archive/2.7.5.tar.gz";
#       sha256 = "02fiqf4rcrxbcgvj02mpd78wkxsrnbi54aciwh9fv5mnz5ka249m";
#     };
#   };

  nerdtree-git-latest = buildVimPlugin {
    name = "nerdtree-git-latest";
    src = pkgs.fetchFromGitHub {
      owner = "Xuyuanp";
      repo = "nerdtree-git-plugin";
      rev = "6b843d3742d01b98a229ed2e6d3782f6d3f21651";
      sha256 = "10mc9ir2h9swbyqfvg4gl3qkyc95s478wfl449zypsjnfisq7526";
    };
  };
}


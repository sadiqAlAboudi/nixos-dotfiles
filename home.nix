{ config, pkgs, ...}:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
  };
in

{
    home.username = "sadiq";
    home.homeDirectory = "/home/sadiq";
    home.stateVersion = "26.05";
    programs.git.enable = true;
    programs.bash = {
        enable = true;
        shellAliases = {
            vim = "nvim";
        };
    };

    xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;
    
    home.packages = with pkgs; [
	neovim
	ripgrep
	nil
	nixpkgs-fmt
	nodejs
	gcc
    ];
}

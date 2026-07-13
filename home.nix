{ config, pkgs, inputs, ...}:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {};
in

{
    home.username = "sadiq";
    home.homeDirectory = "/home/sadiq";
    home.stateVersion = "26.05";
    programs.git = {
        enable = true;
        userName = "sadiqAlAboudi";
        userEmail = "sadiq.m.alaboudi@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    programs.bash = {
        enable = true;
        shellAliases = {
            vim = "nvim";
        };
    };

    programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";
    };

    xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;
    
    home.packages = with pkgs; [
    inputs.zen-browser.packages."${pkgs.system}".default
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    google-chrome
    anydesk
    ];
}

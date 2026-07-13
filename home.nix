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
        settings = {
            user = {
                name = "sadiqAlAboudi";
                email = "sadiq.m.alaboudi@gmail.com";
            };
            core.editor = "vim";
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
        enableDefaultConfig = false;
        settings = {
            "*" = {
            AddKeysToAgent = "yes";
            };
        };
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

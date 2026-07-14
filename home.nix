{ config, pkgs, inputs, ... }

let
  dotfiles = "${config.home.homeDirectory}/nixos-configs/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {};
in

{

  imports = [
    ./modules
    inputs.noctalia.homeModules.default
  ];

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

  programs.noctalia = {
    enable = true;
    # settings = {
    #   Configure your bars, colors, and widgets here later!
    # };
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    google-chrome
    anydesk
    neovim
    go
    xwayland-satellite
  ];
}

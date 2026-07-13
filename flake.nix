{
  description = "NixOS Sadiq Al-Aboudi Version";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.sadiq = import ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}

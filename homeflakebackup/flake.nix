{
  inputs = { nixpkgs, home-manager, ... }: {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    homeConfigurations = {
      "sam@nixos" = home-manager.lib.homeManagerConfiguration {
        username = "sam";
        system = "x86_64-linux";
        configuration = ./home.nix;
        homeDirectory = "/home/sam";
      };
    };
  };
}

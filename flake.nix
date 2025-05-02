{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # this can be stable, but if it is do not make hyprpanel follow it
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = inputs @ {
    nixpkgs,
    stylix,
    ...
  }: let
    system = "x86_64-linux"; # change to whatever your system should be
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit system;
        inherit inputs;
      };
      modules = [
        {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
        stylix.nixosModules.stylix
        ./configuration.nix
      ];
    };
  };
}

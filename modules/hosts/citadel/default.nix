{ self, inputs, ... }:
{
  flake.nixosConfigurations.citadel= inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.citadelConfiguration
      self.nixosModules.home-manager
    ];
  };
}

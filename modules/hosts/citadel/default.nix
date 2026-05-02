{ self, inputs, ... }:
{
  flake.nixosConfigurations.uplink = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.citadelConfiguration
      self.nixosModules.home-manager
    ];
  };
}

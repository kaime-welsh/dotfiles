{ self, inputs, ... }:
{
  flake.nixosConfigurations.uplink = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.uplinkConfiguration
      self.nixosModules.home-manager
    ];
  };
}

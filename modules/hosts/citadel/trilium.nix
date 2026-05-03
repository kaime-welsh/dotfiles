{ self, inputs, ... }:
{
  flake.nixosModules.trilium =
    { pkgs, ... }:
    {
      services.trilium-server = {
        enable = true;
      };
      networking.firewall.allowedTCPPorts = [ 8080 ];
    };
}

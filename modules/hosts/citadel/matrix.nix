{ self, inputs, ... }:
{
  flake.nixosModules.matrix =
    { pkgs, ... }:
    {
      services.matrix-continuwuity = {
        enable = true;
        package = inputs.continuwuity.packages.${pkgs.stdenv.hostPlatform.system}.default;
        settings = {
          global = {
            server_name = "toadstool.online";
            new_user_displayname_suffix = "";
            allow_announcements_check = true;
            allow_registration = true;
            allow_federation = true;
            registration_token = "WelcomeToTheToadstool!";

            address = [ "0.0.0.0" ];
            
            trusted_servers = [
              "matrix.org"
              "unredacted.org"
              "mozilla.org"
              "nixos.org"
              "continuwuity.org"
              "federated.nexus"
            ];

            well_known.client = "https://toadstool.online";
            well_known.server = "toadstool.online:443";
            support_mxid = "@wibblyfrog:toadstool.online";

            matrix_rtc.foci = [
              {
                type = "livekit";
                livekit_service_url = "https://livekit.toadstool.online";
              }
            ];
          };
        };
      };
      networking.firewall.allowedTCPPorts = [ 6167 ];
    };
}

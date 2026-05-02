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

            # registration_terms = {}; # TODO: Need to make policy page
            # TODO: Build a better list?
            trusted_servers = [
              "matrix.org"
              "nixos.org"
            ];

            turn_allow_guest = true;
            turn_uris = [
              "turn:toadstool.online?transport=udp"
              "turn:toadstool.online?transport=tcp"
              "turns:toadstool.online?transport=udp"
              "turns:toadstool.online?transport=tcp"
            ];
            turn_secret = "QXOt8YIy9MG7W8BKgJThtUsgwpKg4xr13HxQZm5tlUgxsjM2wePEv5AydOcwdRN9";
            turn_ttl = 86400;

            well_known.client = "https://toadstool.online";
            well_known.server = "toadstool.online:443";
            support_mxid = "@wibblyfrog:toadstool.online";

            matrix.rtc.foci = [
              {
                type = "livekit";
                livekit_service_url = "https://livekit.toadstool.online";
              }
            ];

            # TODO: Setup Meowlnir
            # antispam.meowlnix = {
            #   base_url = "http://127.0.0.1:29339";
            #   secret = "";
            #   management_room = "";
            #   check_all_joins = true;
            # };
          };
        };

      };
      networking.firewall.allowedTCPPorts = [ 6167 ];
    };
}

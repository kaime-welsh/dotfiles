{ self, inputs, ... }:
{
  flake.nixosModules.citadelConfiguration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.citadelHardware
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "citadel";
      networking.networkmanager.enable = true;
      networking.wireless.enable = false;

      time.timeZone = "America/Los_Angeles";

      services.displayManager.ly = {
        enable = true;
        settings = {
          animate = true;
          animation = "colormix";
        };
      };

      users.users.sysop = {
        isNormalUser = true;
        description = "SYSOP";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
      };

      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [
        vim
        curl
        wget
        git

        fastfetch
        zellij
        yazi
        lazygit
        bottom
        bat
        xclip
        xsel
        wl-clipboard
        nixpkgs-fmt

        cachix
      ];

      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

      virtualisation.docker = {
        enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        }:
      };
      services.openssh.enable = true;
      services.openssh.openFirewall = true;
      services.tailscale.enable = true;

      system.stateVersion = "25.11";
    };
}

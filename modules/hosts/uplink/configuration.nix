{ self, inputs, ... }:
{
  flake.nixosModules.uplinkConfiguration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.uplinkHardware
        self.nixosModules.niri
        self.nixosModules.gaming
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "uplink";
      networking.networkmanager.enable = true;

      time.timeZone = "America/Los_Angeles";

      services.xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
      };

      services.displayManager.ly = {
        enable = true;
        settings = {
          animate = true;
          animation = "colormix";
        };
      };

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      users.users.sysop = {
        isNormalUser = true;
        description = "SYSOP";
        extraGroups = [
          "networkmanager"
          "wheel"
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
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      programs.xwayland.enable = true;
      services.upower.enable = true;
      services.flatpak.enable = true;

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      system.stateVersion = "25.11";
    };
}

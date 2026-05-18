{ self, inputs, ... }:
{
  flake.nixosModules.voyagerConfiguration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.voyagerHardware
        self.nixosModules.niri
        self.nixosModules.gaming
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      hardware.i2c.enable = true;

      networking.hostName = "voyager";
      networking.networkmanager.enable = true;

      time.timeZone = "America/Los_Angeles";

      services.xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
        videoDrivers = [ "nvidia" ];
      };
      services.desktopManager.gnome.enable = true;

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

      hardware.graphics.enable = true;
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
      };
      hardware.uinput.enable = true;

      users.users.sysop = {
        isNormalUser = true;
        description = "SYSOP";
        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
          "uinput"
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
        firefoxpwa
        ddcutil
        openrgb-with-all-plugins
      ];

      programs.firefox = {
        enable = true;
        package = pkgs.firefox;
        nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
      };

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

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      services.hardware.openrgb.enable = true;
      programs.xwayland.enable = true;
      services.upower.enable = true;
      services.flatpak.enable = true;

      services.openssh.enable = true;
      services.openssh.openFirewall = true;
      services.tailscale.enable = true;
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
      };

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      networking.firewall.allowedTCPPorts = [ 2001 ];
      networking.firewall.allowedUDPPorts = [ 2001 ];

      system.stateVersion = "25.11";
    };
}

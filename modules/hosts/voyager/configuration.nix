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
        self.nixosModules.zen-browser
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "voyager";
      networking.networkmanager.enable = true;

      time.timeZone = "America/Los_Angeles";

      services.xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
        videoDrivers = [ "nvidia" ];
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

      hardware.graphics.enable = true;
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
      };

      users.users.sysop = {
        isNormalUser = true;
        description = "SYSOP";
        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
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

      services.openssh.enable = true;
      services.openssh.openFirewall = true;

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      system.stateVersion = "25.11";
    };
}

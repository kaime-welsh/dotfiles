{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.niri
        pkgs.brightnessctl
        pkgs.playerctl
        pkgs.noctalia-shell
        pkgs.fuzzel
        pkgs.xwayland-satellite
      ];

      programs.niri.enable = true;
      programs.xwayland.enable = true;
      services.gnome.gnome-keyring.enable = true;
    };

  flake.homeModules.niri =
    { pkgs, config, ... }:
    {
      xdg.configFile."niri".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/niri";
    };
}

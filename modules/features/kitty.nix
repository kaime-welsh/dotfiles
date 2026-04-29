{ self, inputs, ... }:
{
  flake.homeModules.kitty =
    { pkgs, config, ... }:
    {
      home.packages = [
        pkgs.kitty
      ];

      xdg.configFile."kitty".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/kitty";
    };
}

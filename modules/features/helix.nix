{ self, inputs, ... }:
{
  flake.homeModules.helix =
    { pkgs, config, ... }:
    {
      home.packages = [
        pkgs.helix
        pkgs.yazi
        pkgs.lazygit
      ];

      xdg.configFile."helix".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/helix";
    };
}

{ self, inputs, ... }:
{
  flake.homeModules.zellij=
    { pkgs, config, ... }:
    {
      home.packages = [
        pkgs.zellij
      ];

      xdg.configFile."zellij".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zellij";
    };
}

{ self, inputs, ... }:
{
  flake.homeModules.noctalia =
    { pkgs, config, ... }:
    {
      xdg.configFile."noctalia".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/noctalia";
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
      };
    };
}

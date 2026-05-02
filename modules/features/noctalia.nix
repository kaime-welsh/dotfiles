{ self, inputs, ... }:
{
  flake.homeModules.noctalia =
    { pkgs, config, ... }:
    {
      # programs needed for various plugins
      home.packages = with pkgs; [
        evtest
        # yt-dlp
        # mpv
      ];

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

{ self, inputs, ... }:
{
  flake.homeModules.yazi =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        yazi
        udisks
        p7zip
        ffmpeg
        jq
        poppler
        fd
        fzf
        ripgrep
        resvg
        file
        chafa
        imagemagick
        zoxide
      ];

      xdg.configFile."yazi".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/yazi";
    };
}

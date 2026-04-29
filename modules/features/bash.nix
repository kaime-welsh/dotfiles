{ self, inputs, ... }:
{
  flake.homeModules.bash =
    { pkgs, ... }:
    {
      home.sessionVariables = {
        EDITOR = "hx";
        ZELLIJ_AUTO_EXIT = "true";
      };

      home.packages = with pkgs; [
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
        nil
      ];

      programs.bash = {
        enable = true;
        shellAliases = {
          rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#uplink";
          clean = "sudo nix-collect-garbage -d";
          z = "zellij";
          lg = "lazygit";
          y = "yazi";
        };
        initExtra = ''
          if [[ -z "$ZELLIJ" ]]; then
            if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
              zellij attach -c
            else
              zellij
            fi
            if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
              exit
            fi
          fi
          fastfetch
        '';
      };
    };
}

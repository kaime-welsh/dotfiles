{ self, inputs, ... }:
{
  flake.homeModules.bash =
    { pkgs, config, ... }:
    {
      home.sessionVariables = {
        EDITOR = "hx";
        # ZELLIJ_AUTO_ATTACH = "true";
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
        direnv
      ];

      programs.bash = {
        enable = true;
        shellAliases = {
          rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#${builtins.getEnv "HOSTNAME"}";
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
          eval "$(direnv hook bash)"
        '';
      };
    };
}

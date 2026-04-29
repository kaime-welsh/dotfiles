{ self, input, ... }:
{
  flake.homeModules.git =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Kaime Welsh";
            email = "kaime.r.welsh@gmail.com";
          };
          init.defaultBranch = "main";
        };
      };
    };
}

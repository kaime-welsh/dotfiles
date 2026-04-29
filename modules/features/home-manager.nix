{ self, inputs, ... }:
{
	flake.nixosModules.home-manager = { pkgs, config, ... }:
	{
		imports = [
			inputs.home-manager.nixosModules.default
		];
		home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			extraSpecialArgs = { inherit self inputs; };
			users.sysop = {
				imports = [
					self.homeModules.bash
					self.homeModules.git
					self.homeModules.zellij
					self.homeModules.yazi
					self.homeModules.helix
					self.homeModules.librewolf
					self.homeModules.niri
					self.homeModules.kitty
					self.homeModules.noctalia
					{
						home.username = "sysop";
						home.homeDirectory = "/home/sysop";
						home.stateVersion = "25.11";
					}
				];
			};
		};
	};
}

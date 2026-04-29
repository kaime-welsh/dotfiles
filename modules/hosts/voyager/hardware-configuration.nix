{ self, inputs, ...}:
{

	flake.nixosModules.voyagerHardware = { config, lib, pkgs, modulesPath, ... }:
	{
	  imports =
	    [ (modulesPath + "/installer/scan/not-detected.nix")
	    ];

	  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" ];
	  boot.initrd.kernelModules = [ ];
	  boot.kernelModules = [ "kvm-intel" ];
	  boot.extraModulePackages = [ ];

	  fileSystems."/" =
	    { device = "/dev/disk/by-uuid/2afe19dd-6d7c-4f11-b858-7bcd66edaa94";
	      fsType = "ext4";
	    };

	  fileSystems."/boot" =
	    { device = "/dev/disk/by-uuid/72F0-8338";
	      fsType = "vfat";
	      options = [ "fmask=0077" "dmask=0077" ];
	    };

	  swapDevices =
	    [ { device = "/dev/disk/by-uuid/5d922404-596a-4da0-a859-2da9001cb75b"; }
	    ];

	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}

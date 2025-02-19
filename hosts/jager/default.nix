{
  nixos-hardware,
  config,
  ...
}: {
  imports = [
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    nixos-hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
      useOSProber = true;
    };
  };

  networking = {
    hostName = "jager";

    wireless.enable = false;

    networkmanager.enable = true;
  };

  time.hardwareClockInLocalTime = true;

  services.xserver.videoDrivers = ["nvidia"];

  services.openssh.enable = true;

  hardware = {
    nvidia = {
      modesetting.enable = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  system.stateVersion = "24.05";
}

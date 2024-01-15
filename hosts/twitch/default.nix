{
  pkgs,
  nixos-hardware,
  ...
}: {
  imports = [
    nixos-hardware.nixosModules.asus-battery
    nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    nixos-hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    sof-firmware
    ccid
    libcamera
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
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
    hostName = "twitch";

    networkmanager.enable = true;
  };

  time.hardwareClockInLocalTime = true;

  services.openssh.enable = true;

  services.pcscd.enable = true;

  hardware = {
    opengl = {
      enable = true;
    };

    bluetooth.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

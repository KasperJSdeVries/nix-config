{
  imports = [./hardware-configuration.nix];

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

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  system.stateVersion = "24.05";
}

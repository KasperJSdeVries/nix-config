{
  imports = [./hardware-configuration.nix];

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

  services.xserver.videoDrivers = ["intel"];

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}

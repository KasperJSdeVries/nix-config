{...}: {
  imports = [./hardware-configuration.nix];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "jager";

    wireless.enable = false;

    networkmanager.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  services.openssh.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  system.stateVersion = "24.05";
}

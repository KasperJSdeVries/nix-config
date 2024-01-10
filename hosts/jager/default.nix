{...}: {
  imports = [./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;

  system.stateVersion = "24.05";
}

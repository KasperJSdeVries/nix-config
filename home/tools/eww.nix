{pkgs, ...}: {
  home.packages = with pkgs; [
    acpi
    bc
    blueberry
    dunst
    libnotify
    light
    networkmanager_dmenu
    pavucontrol
    python3
  ];

  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
}

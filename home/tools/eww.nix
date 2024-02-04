{pkgs, ...}: {
  home.packages = with pkgs; [
    blueberry
    networkmanager_dmenu
    python3
  ];

  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
}

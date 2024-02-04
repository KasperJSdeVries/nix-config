{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
    discord
    spotify
  ];
}

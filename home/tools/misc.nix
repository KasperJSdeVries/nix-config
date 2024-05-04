{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
    blender
    discord
    exercism
    gparted
    spotify
    obsidian
    renderdoc
    valgrind
    unzip
    zip
  ];
}

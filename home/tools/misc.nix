{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
    blender
    devenv
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

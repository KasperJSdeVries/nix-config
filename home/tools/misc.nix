{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
    blender
    devenv
    discord
    exercism
    gparted
    godot_4
    spotify
    obsidian
    renderdoc
    valgrind
    unzip
    zip
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
    blender
    devenv
    discord
    exercism
    gparted
    godot_4
    obsidian
    renderdoc
    sl
    valgrind
    unzip
    zip
  ];
}

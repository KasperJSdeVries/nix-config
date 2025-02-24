{pkgs, ...}: {
  home.packages = with pkgs; [
    nautilus
    blender
    devenv
    discord
    exercism
    gparted
    godot_4
    obsidian
    renderdoc
    sl
    steam
    valgrind
    wakeonlan
    unzip
    zip
  ];
}

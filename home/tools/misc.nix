{pkgs, ...}: {
  home.packages = with pkgs; [
    nautilus
    blender
    devenv
    discord
    exercism
    ffmpeg
    gparted
    godot_4
    obsidian
    renderdoc
    shutter
    sl
    steam
    valgrind
    vlc
    wakeonlan
    unzip
    zip
  ];
}

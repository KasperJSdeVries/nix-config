{pkgs, ...}: {
  home.packages = with pkgs; [
    blender
    btop
    devenv
    discord
    exercism
    ffmpeg
    gparted
    godot_4
    nautilus
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

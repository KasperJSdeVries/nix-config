{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
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

{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.nautilus
    discord
    exercism
    spotify
    obsidian
    renderdoc
    valgrind
    unzip
    zip
  ];
}

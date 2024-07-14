{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    theme = "catppuccin-mocha";
    font = "Sofia Pro 16";
    location = "center";
    terminal = "${pkgs.kitty}/bin/kitty";
    extraConfig = {
      modi = "run,drun,window";
      lines = 5;
      show-icons = true;
      icon-theme = "Papirus";
      drun-display-format = "{name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " 󰵆  Apps ";
      display-run = " 󰆍  Run ";
      display-window = " 󱂬  Window";
      sidebar-mode = true;
    };
  };

  xdg.dataFile."rofi" = {
    recursive = true;
    source = ./rofi;
  };
}

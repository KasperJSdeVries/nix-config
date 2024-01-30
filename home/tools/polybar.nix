{pkgs, ...}: {
  home.packages = with pkgs; [
    bluez
    bluez-tools
    lsof
    killall
  ];

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      githubSupport = true;
      i3Support = true;
    };

    script = "";
  };

  xdg.configFile."polybar" = {
    source = ./polybar;
    recursive = true;
  };
}

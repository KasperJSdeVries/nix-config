{pkgs, ...}: {
  home.packages = with pkgs; [
    (bluez.override {withExperimental = true;})
    bluez-tools
    lsof
    killall
    xdo
  ];

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      githubSupport = true;
    };

    script = "";
  };

  xdg.configFile."polybar" = {
    source = ./polybar;
    recursive = true;
  };
}

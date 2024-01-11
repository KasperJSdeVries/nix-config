{pkgs, ...}: {
  home.packages = with pkgs; [
    alsa-utils
    playerctl
  ];

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      config = null;
      extraConfig = builtins.readFile ./config;
    };
  };
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
    brightnessctl
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

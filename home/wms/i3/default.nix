{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
    brightnessctl
    xwallpaper
  ];

  services.playerctld.enable = true;

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [];
      keybindings = {};
      startup = [
        {
          command = "xwallpaper --focus ~/.background-image";
          always = true;
          notification = false;
        }
      ];
    };

    extraConfig = builtins.readFile ./config-v4;
  };

  services.picom.enable = true;
}

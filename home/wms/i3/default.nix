{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
    brightnessctl
    xwallpaper
  ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

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

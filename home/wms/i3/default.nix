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

  programs.i3status = {
    enable = true;
    modules = {
      "volume master" = {
        position = 1;
        settings = {
          format = "♪: %volume";
          format_muted = "♪: muted (%volume)";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };
      "wireless _first_".enable = false;
      "ethernet _first_".enable = false;
      "ipv6".enable = false;
    };
  };

  services.picom.enable = true;
}

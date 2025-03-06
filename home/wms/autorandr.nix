{
  services.autorandr = {
    enable = true;
  };

  programs.autorandr = {
    enable = true;

    profiles = {
      jager = {
        config = {
          DP-0 = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "2560x1440";
            rate = "143.97";
          };
          DP-2 = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "1920x1080";
            rate = "360.00";
          };
        };
      };
    };
  };
}

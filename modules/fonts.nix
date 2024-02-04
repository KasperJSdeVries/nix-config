{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      font-awesome
      material-design-icons
      material-icons
      material-symbols
      weather-icons

      # regular fonts
      clarity-city
      dosis
      inter

      # nerdfonts
      (nerdfonts.override {fonts = ["JetBrainsMono" "SpaceMono"];})
    ];

    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}

{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      #nerdfonts
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}

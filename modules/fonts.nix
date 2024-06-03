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
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts

      # nerdfonts
      (nerdfonts.override {fonts = ["JetBrainsMono" "SpaceMono"];})
    ];

    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}

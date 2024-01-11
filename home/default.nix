{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "24.05";

    keyboard = {
      layout = "us";
      options = [
        "eurosign:e"
        "caps:escape"
      ];
      variant = "dvorak";
    };
  };

  programs.home-manager.enable = true;
}

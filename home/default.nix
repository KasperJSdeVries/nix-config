{
  lib,
  username,
  fs,
  ...
}: {
  imports =
    [
      ./wms/i3
    ]
    ++ lib.concatMap (d: map (f: (./. + ("/" + d) + ("/" + f))) (fs.listNixFiles (./. + ("/" + d)))) (fs.listDirs ./.);

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

  home.file.".background-image".source = ../assets/wallpaper;
}

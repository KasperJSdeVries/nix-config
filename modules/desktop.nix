{username, ...}: {
  imports = [
    ./nix.nix
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
    };
  };
}

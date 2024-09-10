{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xclip
  ];

  services.xserver = {
    enable = true;

    windowManager.i3.enable = true;
  };
}

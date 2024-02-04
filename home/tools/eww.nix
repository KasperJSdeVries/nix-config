{pkgs, ...}: {
  home.packages = with pkgs; [
    python3
  ];

  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
}

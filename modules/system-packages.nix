{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    neovim
    git
    wget
  ];
}

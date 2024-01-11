{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      curl
      neovim
      git
      wget
    ];

    variables.EDITOR = "nvim";
  };
}

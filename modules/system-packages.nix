{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      curl
      linux-manual
      man-pages
      man-pages-posix
      neovim
      git
      wget
    ];

    variables.EDITOR = "nvim";
  };

  programs.zsh.enable = true;

  documentation = {
    enable = true;

    dev.enable = true;
    doc.enable = true;
    man.enable = true;
  };
}

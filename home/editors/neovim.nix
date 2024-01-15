{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      clang-tools
      lua-language-server
      neocmakelsp
      nil
    ];
  };

  #xdg.configFile."nvim" = {
  #  source = ./nvim;
  #  recursive = true;
  #};
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    clang-tools
    lua-language-server
    neocmakelsp
    nil
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}

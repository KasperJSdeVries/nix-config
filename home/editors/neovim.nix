{pkgs, ...}: {
  home.packages = with pkgs; [
    clang-tools
    fd
    gcc
    lua-language-server
    neocmakelsp
    nil
    ripgrep
    tree-sitter
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}

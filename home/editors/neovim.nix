{pkgs, ...}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.css
    p.glsl
    p.html
    p.javascript
    p.lua
    p.markdown
    p.markdown_inline
    p.nix
    p.regex
    p.sql
  ]);
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    plugins = [treesitterWithGrammars];

    extraPackages = with pkgs; [
      clang-tools
      fd
      lua-language-server
      neocmakelsp
      nil
      ripgrep
      vscode-langservers-extracted
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  xdg.dataFile."nvim/nix/nvim-treesitter" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}

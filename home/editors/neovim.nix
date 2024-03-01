{pkgs, ...}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    plugins = [treesitterWithGrammars];

    extraPackages = with pkgs; [
      clang-tools
      docker-compose-language-service
      fd
      latexrun
      lua-language-server
      neocmakelsp
      nil
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-langservers-extracted
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      pplatex
      ripgrep
      rust-analyzer
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

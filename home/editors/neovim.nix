{pkgs, ...}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    plugins = [treesitterWithGrammars];

    extraPackages = with pkgs; [
      fd
      ripgrep
      tree-sitter
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

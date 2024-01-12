{pkgs, ...}:
## for if you want to add a non pkgs.tmuxPlugins tmux plugin
#let
#  mem-cpu-load =
#    pkgs.tmuxPlugins.mkTmuxPlugin
#    {
#      inherit (pkgs.tmux-mem-cpu-load) src name;
#      pluginName = "mem-cpu-load";
#    };
#in
{
  programs.tmux = {
    enable = true;

    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
        '';
      }
      pkgs.tmuxPlugins.urlview
      pkgs.tmuxPlugins.yank
    ];

    customPaneNavigationAndResize = true;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;

    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
  };
}

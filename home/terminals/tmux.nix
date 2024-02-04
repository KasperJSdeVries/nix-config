{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'

          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"
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

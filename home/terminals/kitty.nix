{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetbrainsMono NF";
      size = 14;
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      enable_audio_bell = "no";
      shell = "${pkgs.tmux}/bin/tmux new-session -A -D -s main";
      #shell = "${pkgs.zsh}/bin/zsh";
      background_opacity = "0.7";
    };
    #keybindings = {
    #  "ctrl+shift+h" = "previous_tab";
    #  "ctrl+shift+l" = "next_tab";
    #  "ctrl+alt+enter" = "launch --cwd=current";
    #  "ctrl+alt+t" = "detach_window new-tab";
    #  "ctrl+alt+l" = "next_layout";
    #  "ctrl+alt+p" = "previous_layout";
    #};
    theme = "Catppuccin-Mocha";
  };
}

{
  config,
  pkgs,
  ...
}: let
  alacritty-theme = builtins.readFile (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/catppuccin_mocha.toml";
    sha256 = "0vv3hfsrnp6wpj8s2k76kq2ngg1xycm915rdr2kmkq93rm0rm30x";
  });

  theme-path = "${config.xdg.configHome}/alacritty/theme.toml";
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [theme-path];
      #shell.program = "./open_tmux.sh";
      shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = ["new-session" "-A" "-D" "-s" "main"];
      };
      window = {
        opacity = 0.7;
      };
    };
  };

  xdg.configFile."alacritty/open_tmux.sh" = {
    source = ./open_tmux.sh;
    executable = true;
  };

  xdg.configFile."alacritty/theme.toml".text = alacritty-theme;
}

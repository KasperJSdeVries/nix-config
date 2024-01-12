{
  config,
  pkgs,
  ...
}: let
  #alacritty-theme = builtins.readFile ((fetchGit {url = "https://github.com/alacritty/alacritty-theme";}).outPath + "/themes/catppuccin_mocha.toml");
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
      shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = ["new-session" "-A" "-D" "-s" "main"];
      };
    };
  };

  xdg.configFile = {
    "alacritty/theme.toml".text = alacritty-theme;
  };
}

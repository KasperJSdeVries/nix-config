{
  pkgs,
  config,
  lib,
  ...
}: let
  zsh_dir = "${config.xdg.configHome}/zsh";
in {
  home.packages = with pkgs; [
    direnv
  ];

  programs.zsh = {
    enable = true;

    history = {
      path = "${zsh_dir}/.zsh_history";
    };

    dotDir = lib.removePrefix config.home.homeDirectory zsh_dir;

    completionInit = ''
      autoload -Uz compinit
      compinit -d ${zsh_dir}/.zcompdump
    '';

    envExtra = ''
      export SHELL_SESSIONS_DISABLE=1
    '';

    initExtra = ''
      eval "$(direnv hook zsh)"
    '';

    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      gap = "git add -p";
      gcm = "git commit -m";
      gs = "git status";
      gck = "git checkout";
      gpu = "git pull";
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };

    shellAliases = {
      v = "nvim";
    };
  };
}

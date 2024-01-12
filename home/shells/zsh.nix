{
  config,
  lib,
  ...
}: let
  zsh_dir = "${config.xdg.configHome}/zsh";
in {
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

    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };

    shellAliases = {
      v = "nvim";
    };
  };
}

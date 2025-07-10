{pkgs, ...}: {
  home.packages = with pkgs; [
    graphite-cli
  ];

  programs.git = {
    enable = true;

    userName = "KasperJSdeVries";
    userEmail = "89792927+KasperJSdeVries@users.noreply.github.com";

    lfs.enable = true;

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.gh = {
    enable = true;

    extensions = with pkgs; [
      act
    ];

    settings.editor = "nvim";
  };
}

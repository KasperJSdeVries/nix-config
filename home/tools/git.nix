{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "KasperJSdeVries";
    userEmail = "89792927+KasperJSdeVries@users.noreply.github.com";
  };

  programs.gh = {
    enable = true;

    extensions = [ pkgs.act ];

    settings.editor = "nvim";
  };
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    graphite-cli
  ];

  programs.git = {
    enable = true;

    userName = "KasperJSdeVries";
    userEmail = "89792927+KasperJSdeVries@users.noreply.github.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      "includeIf \"gitdir:~/projects/school/\"" = {
        path = "~/projects/school/.gitconfig";
      };
    };
  };

  home.file."projects/school/.gitconfig" = {
    text = ''
      [user]
      name = Kasper de Vries
      email = k.j.s.devries@student.tudelft.nl
    '';
  };

  programs.gh = {
    enable = true;

    extensions = with pkgs; [
      act
    ];

    settings.editor = "nvim";
  };
}

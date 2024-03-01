{pkgs, ...}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-full
      ;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  };
in {
  home.packages = [
    tex
  ];
}

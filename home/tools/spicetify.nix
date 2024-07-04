{
  pkgs,
  spicetify-nix,
  ...
}: let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;

  podpahExtensions = fetchGit {
    url = "https://github.com/podpah/Spicetify-Extensions";
    rev = "a3f838de7e7f4ae67914e41bb2e3a313bb413d14";
  };

  adufrExtensions = fetchGit {
    url = "https://github.com/adufr/spicetify-extensions.git";
    rev = "4af311ecf572cd112f3b954c1d1446eebbda0180";
  };

  genresSrc = fetchGit {
    url = "https://github.com/LucasOe/spicetify-genres.git";
    rev = "be69d720332e4ce695574b01604e08e0404e7aa3";
  };

  statsSrc = pkgs.fetchzip {
    url = "https://github.com/harbassan/spicetify-apps/releases/download/stats-v0.3.3/spicetify-stats.release.zip";
    sha256 = "0prm8qs9zr7ly8z33iyfnsw52dhp55bkvdw00fhgdw45wjfw7gbf";
  };

  librarySrc = pkgs.fetchzip {
    url = "https://github.com/harbassan/spicetify-apps/releases/download/library-v0.1.1/spicetify-library.release.zip";
    sha256 = "1yfnkh68g1s9ch8mf9sw9dwz80bgqkvkbxqffyxz7p4nm03133f5";
  };
in {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledCustomApps = [
      {
        name = "library";
        src = "${librarySrc}";
        appendName = false;
      }
      {
        name = "stats";
        src = "${statsSrc}";
        appendName = false;
      }
    ];

    enabledExtensions = with spicePkgs.extensions; [
      featureShuffle
      hidePodcasts
      historyShortcut
      keyboardShortcut
      lastfm
      shuffle
      showQueueDuration
      trashbin
      {
        src = "${podpahExtensions}/queueShuffler";
        filename = "queueShuffler.js";
      }
      {
        src = "${adufrExtensions}/quick-add-to-playlist/dist";
        filename = "quick-add-to-playlist.js";
      }
      {
        src = "${adufrExtensions}/quick-add-to-queue/dist";
        filename = "quick-add-to-queue.js";
      }
      {
        src = "${genresSrc}/dist";
        filename = "whatsThatGenre.js";
      }
    ];
  };
}

{
  pkgs,
  spicetify-nix,
  ...
}: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};

  podpahExtensions = fetchGit {
    url = "https://github.com/podpah/Spicetify-Extensions";
    rev = "a3f838de7e7f4ae67914e41bb2e3a313bb413d14";
  };

  adufrExtensions = fetchGit {
    url = "https://github.com/adufr/spicetify-extensions.git";
    rev = "4af311ecf572cd112f3b954c1d1446eebbda0180";
  };

  anonymizedRadiosSrc = fetchGit {
    url = "https://github.com/BitesizedLion/AnonymizedRadios.git";
    rev = "1741f9ba19fe5e20183b3e65210ed6dec3bac17d";
  };

  statsSrc = pkgs.fetchzip {
    url = "https://github.com/harbassan/spicetify-apps/releases/download/stats-v1.1.1/spicetify-stats.release.zip";
    sha256 = "096z2zgn96j2l9mz02p6q4z9gdckj6fhjd83s5wc57nlm2f1jr3g";
  };

  librarySrc = pkgs.fetchzip {
    url = "https://github.com/harbassan/spicetify-apps/releases/download/library-v1.0.0/spicetify-library.release.zip";
    sha256 = "14plmnlrq3rb7pl2bjdya2y60ybzwq0nk96qn6ysnir82bczs36a";
  };
in {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledCustomApps = [
      spicePkgs.apps.marketplace
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
      betterGenres
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
        name = "queueShuffler.js";
      }
      {
        src = "${adufrExtensions}/quick-add-to-playlist/dist";
        name = "quick-add-to-playlist.js";
      }
      {
        src = "${adufrExtensions}/quick-add-to-queue/dist";
        name = "quick-add-to-queue.js";
      }
      {
        src = anonymizedRadiosSrc;
        name = "AnonymizedRadios.js";
      }
    ];
  };
}

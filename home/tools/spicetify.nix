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
in {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    ## NOTE: Enable to browse extensions

    # enabledCustomApps = with spicePkgs.apps; [
    #   marketplace
    # ];

    enabledExtensions = with spicePkgs.extensions; [
      featureShuffle
      #fullAppDisplay
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
    ];
  };
}

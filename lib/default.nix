{lib}: {
  fs = import ./fs.nix {inherit lib;};
  attrs = import ./attrs.nix {inherit lib;};
}

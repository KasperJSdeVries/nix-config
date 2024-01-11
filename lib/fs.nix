{lib, ...}: let
  inherit (builtins) attrNames filter readDir;
in {
  listDirs = dir: attrNames (lib.filterAttrs (name: value: value == "directory") (readDir dir));
  listNixFiles = dir: filter (f: lib.hasSuffix ".nix" f) (attrNames (readDir dir));
}

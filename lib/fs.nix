{lib, ...}: {
  listDirs = dir: builtins.attrNames (lib.filterAttrs (name: value: value == "directory") (builtins.readDir dir));
}

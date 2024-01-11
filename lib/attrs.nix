{lib, ...}: let
  inherit (builtins) listToAttrs concatMap;
in {
  genAttrMatrix = l1: l2: nameFn: valueFn:
    listToAttrs (concatMap (a: map (b: lib.nameValuePair (nameFn a b) (valueFn a b)) l2) l1);
}

{
  lib,
  nixpkgs,
  username,
  ...
}: {
  nix = {
    registry.nixpkgs.flake = nixpkgs;
    channel.enable = false;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      trusted-users = ["root" username];
    };

    gc = {
      automatic = true;
    };
  };

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
}

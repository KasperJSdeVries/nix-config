{inputs, ...}: let
  inherit (inputs) nixpkgs;
in {
  flake.nixosConfigurations = {
    jager = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./jager];
    };
  };
}

{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];

  perSystem.pre-commit.settings = {
    excludes = ["flake.lock"];

    hooks = {
      actionlint.enable = true;
      alejandra.enable = true;
      markdownlint.enable = true;
      statix.enable = true;
    };

    settings = {
      statix.ignore = ["hardware-configuration.nix"];
    };
  };
}

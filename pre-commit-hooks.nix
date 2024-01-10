{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];

  perSystem.pre-commit = {
    settings.excludes = ["flake.lock"];

    settings.hooks = {
      actionlint.enable = true;
      alejandra.enable = true;
      markdownlint.enable = true;
    };
  };
}

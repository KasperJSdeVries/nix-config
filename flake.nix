{
  description = "NixOS Config";

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (nixpkgs) lib;
    inherit (import ./lib {inherit lib;}) fs;

    # Constants
    username = "kasper";

    # Configs
    hosts = fs.listDirs ./hosts;
    profiles = fs.listDirs ./profiles;
    modules = fs.listNixFiles ./modules;
  in {
    homeConfigurations = lib.genAttrs profiles (
      name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles" + ("/" + "${name}"))
            ./home
          ];
          extraSpecialArgs = {
            inherit username;
          };
        }
    );

    nixosConfigurations = lib.genAttrs hosts (
      name:
        lib.nixosSystem {
          inherit system;
          modules =
            [
              (./. + "/hosts" + ("/" + "${name}"))
            ]
            ++ (builtins.map (x: (./. + "/modules" + ("/" + "${x}"))) modules);
          specialArgs = {inherit username;};
        }
    );

    checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
      src = ./.;

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

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        git
      ];

      shellHook = ''
        ${self.checks.${system}.pre-commit-check.shellHook}
      '';
    };

    formatter.${system} = pkgs.alejandra;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

{
  description = "NixOS Config";

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (nixpkgs) lib;
    inherit (import ./lib {inherit lib;}) fs attrs;

    # Constants
    username = "kasper";

    # Configs
    hosts = fs.listDirs ./hosts;
    profiles = fs.listDirs ./profiles;
    modules = fs.listNixFiles ./modules;
  in {
    nixosConfigurations = lib.genAttrs hosts (
      host:
        lib.nixosSystem {
          inherit system;
          modules =
            [
              (./. + "/hosts" + ("/" + "${host}"))
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./home;
                  extraSpecialArgs = {
                    inherit username;
                    inherit fs;
                    inherit (inputs) spicetify-nix;
                  };
                };
              }
            ]
            ++ (builtins.map (x: (./. + "/modules" + ("/" + "${x}"))) modules);
          specialArgs = {
            inherit username;
            inherit (inputs) nixpkgs nixos-hardware lanzaboote;
          };
        }
    );

    checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
      src = ./.;

      excludes = ["flake.lock"];

      hooks = {
        actionlint.enable = true;
        alejandra.enable = true;
        markdownlint.enable = true;
        statix = {
          enable = true;
          settings.ignore = ["hardware-configuration.nix"];
        };
        stylua.enable = true;
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        git
        nil
        lua-language-server
        yaml-language-server
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

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks-nix.follows = "pre-commit-hooks";
      };
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

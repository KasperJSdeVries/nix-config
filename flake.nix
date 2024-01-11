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
    #homeConfigurations = {
    #  ${username} = home-manager.lib.homeManagerConfiguration {
    #    inherit pkgs;
    #    modules = [
    #      ./home
    #    ];
    #    extraSpecialArgs = {
    #      inherit username;
    #    };
    #  };
    #};

    nixosConfigurations =
      attrs.genAttrMatrix hosts profiles
      (host: profile: "${host}" + "_" + "${profile}")
      (
        host: profile:
          lib.nixosSystem {
            inherit system;
            modules =
              [
                (./. + "/hosts" + ("/" + "${host}"))
                (./. + "/profiles" + ("/" + "${profile}"))
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${username} = import ./home;
                    extraSpecialArgs = {
                      inherit username;
                      inherit fs;
                    };
                  };
                }
              ]
              ++ (builtins.map (x: (./. + "/modules" + ("/" + "${x}"))) modules);
            specialArgs = {
              inherit username;
              inherit (inputs) nixpkgs;
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

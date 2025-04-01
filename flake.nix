rec {
  description = "NixOS configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    extensions.url = "github:nix-community/nix-vscode-extensions";
    extensions.inputs.nixpkgs.follows = "nixpkgs";
    editor-010.url = "github:Sanae6/010editor-flake";
    editor-010.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    editor-010,
    extensions,
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    extensions = extensions.extensions.x86_64-linux;

    nixosConfigurations.aubrey-laptop-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        unstablePkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        _010editor = editor-010.packages.x86_64-linux.default;
        extensions = extensions.extensions.x86_64-linux;
      };
      modules = [./configuration/configuration.nix];
    };
  };
}

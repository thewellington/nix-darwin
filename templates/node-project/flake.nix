{
  description = "Node project dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs_22
        # Add project-specific tools here, e.g. pkgs.nodePackages.typescript
      ];

      shellHook = ''
        echo "Node $(node --version), npm $(npm --version)"
      '';
    };
  };
}

let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.google-api-python-client
      python-pkgs.google-auth-oauthlib
      python-pkgs.google-auth-httplib2
      python-pkgs.uv
    ]))
    pkgs.mcp-nixos

  ];
}

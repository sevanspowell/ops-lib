{ sourcePaths ? import ./nix/sources.nix
, system ? builtins.currentSystem
, crossSystem ? null
, config ? {} }@args: with import ./nix args; {
  inherit nixops nginxStable nginxMainline;
  overlays = import ./overlays sourcePaths;
  shell = mkShell {
    # NIX_SSL_CERT_FILE needs to be set otherwise nix-prefetch-url
    # throws: error: unable to download '...': Problem with the SSL CA
    # cert (path? access rights?) (77)
    NIX_SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    buildInputs = [ niv
                    nix # Added for nix-prefetch-url, needed by niv to update nixpkgs
                  ];
  };
}

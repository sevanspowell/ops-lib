{ pkgs, name, ... }:
let inherit (pkgs.globals) domain;
in {
  nixpkgs.localSystem.system = "x86_64-linux";
  imports = [ ../../modules/aws.nix ];
  node = { fqdn = "${name}.${domain}"; };

  services.nginx.mapHashBucketSize = 128;
}

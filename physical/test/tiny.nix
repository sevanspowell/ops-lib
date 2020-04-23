{ pkgs, ... }: {
  imports = [ ./common.nix ];
  virtualisation.memorySize = 512;
}

{ pkgs, ... }: {
  imports = [ ./common.nix ];
  virtualisation.memorySize = 8 * 1024;
}

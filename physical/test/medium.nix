{ pkgs, ... }: {
  imports = [ ./common.nix ];
  virtualisation.memorySize = 2 * 1024;
}

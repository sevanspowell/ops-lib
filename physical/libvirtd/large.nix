{ pkgs, ... }: {
  imports = [ ./common.nix ];
  deployment.libvirtd.memorySize = 8 * 1024;
}

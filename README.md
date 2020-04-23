# ops-lib
NixOps deployment configuration library for IOHK devops 

## How to setup for libvirtd

NixOS configuration:

``` nix
  # Enable lib
  virtualisation.libvirtd.enable = true;
  users.extraUsers.sam = {
    extraGroups = [ ... "libvirtd"];
    # ...
  };
```

``` shell
  $ sudo nixos-rebuild switch
  # logout and in again.
```

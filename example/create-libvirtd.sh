#!/usr/bin/env bash

set -euxo pipefail

# https://nixos.org/nixops/manual/#idm140737322394336
# Needed for libvirtd:
#
# virtualisation.libvirtd.enable = true;
# networking.firewall.checkReversePath = false;

# See also: https://github.com/simon3z/virt-deploy/issues/8#issuecomment-73111541

if [ ! -d /var/lib/libvirt/images ]; then
  sudo mkdir -p /var/lib/libvirt/images
  sudo chgrp libvirtd /var/lib/libvirt/images
  sudo chmod g+w /var/lib/libvirt/images
fi

# if [ ! virsh pool-info default ]; then
#   sudo virsh pool-define /dev/stdin <<EOF
# <pool type='dir'>
#   <name>default</name>
#   <target>
#     <path>/var/lib/libvirt/images</path>
#   </target>
# </pool>
# EOF
#   sudo virsh pool-start default
#   sudo virsh pool-autostart default
# fi

# Credential setup
if [ ! -f ./static/graylog-creds.nix ]; then
  nix-shell -A gen-graylog-creds
fi

nixops destroy || true
nixops delete || true
nixops create ./deployments/example-libvirtd.nix -I nixpkgs=./nix
nixops deploy --show-trace

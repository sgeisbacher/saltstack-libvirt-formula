{% from "libvirt/map.jinja" import libvirt with context %}

libvirt_packages:
  pkg.installed:
    - pkgs:
      - qemu-kvm
      - libvirt
      - virt-install
      - bridge-utils

libvirtd:
  service.running: []
  - require:
    - pkg: libvirt

/root/libvirt-configs:
  file.directory: []


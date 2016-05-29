{% from "libvirt/map.jinja" import libvirt with context %}

include:
    - libvirt.init

/root/libvirt-configs/guests:
  file.directory:
    - require:
      - file: /root/libvirt-configs



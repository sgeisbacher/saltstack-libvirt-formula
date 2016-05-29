{% from "libvirt/map.jinja" import libvirt with context %}

include:
    - libvirt.init

/root/libvirt-configs/net:
  file.directory:
    - require:
      - file: /root/libvirt-configs


{% for bridge in libvirt.bridges %}

libvirt_kvm_bridge_{{ bridge.name }}:
  file.managed:
    - name: /root/libvirt-configs/net/kvm_{{ bridge.name }}.xml
    - source: salt://libvirt/files/kvm-net-config.xml.jinja
    - template: jinja
    - context:
      bridge: {{ bridge }}
    - require:
      - file: /root/libvirt-configs/net

libvirt_kvm_bridge_create_{{ bridge.name }}:
  cmd.run:
    - name: virsh net-create /root/libvirt-configs/net/kvm_{{ bridge.name }}.xml
    - unless: ifconfig {{ bridge.name }}
    - require:
      - file: libvirt_kvm_bridge_{{ bridge.name }}

{% endfor %}

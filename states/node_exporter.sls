{% if not salt['file.file_exists']('/usr/local/bin/node_exporter') %}

{% if ('arm64' in grains['osarch']) %}
retrieve_node_exporter:
  cmd.run:
    - name: wget -O /tmp/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-arm64.tar.gz

extract_node_exporter:
  archive.extracted:
    - name: /tmp
    - enforce_toplevel: false
    - source: /tmp/node_exporter.tar.gz
    - archive_format: tar
    - user: root
    - group: root

move_node_exporter:
  file.rename:
    - name: /usr/local/bin/node_exporter
    - source: /tmp/node_exporter-1.0.1.linux-arm64/node_exporter

delete_node_exporter_dir:
  file.absent:
    - name: /tmp/node_exporter-1.0.1.linux-arm64

delete_node_exporter_files:
  file.absent:
    - name: /tmp/node_exporter.tar.gz
{% endif %} 

{% if ('amd64' in grains['osarch']) %}
retrieve_node_exporter:
  cmd.run:
    - name: wget -O /tmp/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.darwin-amd64.tar.gz

extract_node_exporter:
  archive.extracted:
    - name: /tmp
    - enforce_toplevel: false
    - source: /tmp/node_exporter.tar.gz
    - archive_format: tar
    - user: root
    - group: root

move_node_exporter:
  file.rename:
    - name: /usr/local/bin/node_exporter
    - source: /tmp/node_exporter-1.0.1.darwin-amd64/node_exporter

delete_node_exporter_dir:
  file.absent:
    - name: /tmp/node_exporter-1.0.1.darwin-amd64

delete_node_exporter_files:
  file.absent:
    - name: /tmp/node_exporter.tar.gz
{% endif %}

{% endif %}

node_exporter_user:
  user.present:
    - name: node_exporter
    - fullname: Node Exporter
    - shell: /bin/false

node_exporter_group:
  group.present:
    - name: node_exporter

/opt/prometheus/exporters/dist/textfile:
  file.directory:
    - user: node_exporter
    - group: node_exporter
    - mode: 755
    - makedirs: True

/etc/systemd/system/node_exporter.service:
  file.managed:
    - source: salt://exporters/node_exporter/files/node_exporter.service.j2
    - user: root
    - group: root
    - mode: 0644
    - template: jinja

node_exporter_service_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - watch:
      - file: /etc/systemd/system/node_exporter.service

node_exporter_service:
  service.running:
    - name: node_exporter
    - enable: True

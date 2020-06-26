prometheus_node_exporter_service:
  service.running:
    - name: node_exporter.service
    - enable: True
install_packages:
  pkg.installed:
    - pkgs:
      - git
      - docker.io
      - docker-compose
      - iostat
      - vnstat
      - htop
      - nano
      - net-tools
remove_packages:
    pkg.removed:
      - pkgs:
        - snap
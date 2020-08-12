install_packages:
  pkg.installed:
    - pkgs:
      - git
      - docker.io
      - docker-compose
      - iostat
      - sysstat
      - htop
      - nano
      - net-tools
remove_packages:
    pkg.removed:
      - pkgs:
        - snap
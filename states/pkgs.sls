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
      - awscli
remove_packages:
    pkg.removed:
      - pkgs:
        - snap
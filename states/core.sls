core-pkgs:
  pkg.installed:
    - names:
      - ntp
      - net-tools
      - htop
      - lsof
      - vim
      - tmux
      - ack-grep
      - curl
      - netcat
      - git

purged-pkgs:
  pkg.purged:
    - names:
      - nano
      - apache2
      - libapache2-mod-perl2
      - libapache2-reload-perl
      - apache2-doc
      - apache2-mpm-prefork
      - apache2-utils
      - apache2.2-bin
      - apache2.2-common
      - libapache2-mod-php5
      - libapache2-mod-python
      - postgresql-client-8.4
      - postgresql-8.4
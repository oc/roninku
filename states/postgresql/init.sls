postgresql-9.1:
  pkg.installed:
    - repo: squeeze-backports
    - names:
      - libpq5
      - postgresql-common
      - postgresql-9.1
      - postgresql-server-dev-9.1


/etc/postgresql/9.1/main/postgresql.conf:
  file.managed:
    - source: salt://postgresql/etc/postgresql/9.1/main/postgresql.conf.jinja
    - template: jinja
    - defaults:
        listen_addresses: 127.0.0.1
        max_connections: 100
        shared_buffers: 24MB
        effective_cache_size: 128MB
        timezone: 'Europe/Oslo'
    - require:
      - pkg: postgresql-9.1

/etc/postgresql/9.1/main/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/etc/postgresql/9.1/main/pg_hba.conf
    - require:
      - pkg: postgresql-9.1

postgresql:
  service.running:
    - enable: True
    - watch:
      - file: /etc/postgresql/9.1/main/postgresql.conf
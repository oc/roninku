include:
  - postgresql

{% for db in pillar['postgresql_databases'] %}
postgresql_createuser-{{ db.owner }}:
  cmd.run:
    - name: createuser --no-superuser --no-createdb --no-createrole {{ db.owner }}
    - unless: psql --tuples-only -c 'SELECT rolname FROM pg_catalog.pg_roles;' | grep '^ {{ db.owner }}$'
    - user: postgres
    - cwd: '/'
    - require:
      - service: postgresql

postgresql_createdb {{ db.name }}:
  cmd.run:
    - name: createdb -O {{ db.owner }} {{ db.name }}
    - unless: psql -ltA | grep '^{{ db.name }}|'
    - user: postgres
    - cwd: '/'
    - require:
      - cmd: postgresql_createuser-{{ db.owner }}
{% endfor %}
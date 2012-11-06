nginx:
  pkg.installed

nginx-service:
  service.running:
    - name: nginx
    - enable: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/mime.types
      - file: /etc/nginx/sites-enabled/*

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/etc/nginx/nginx.conf.jinja
    - template: jinja
    - defaults:
        worker_user: www-data
        worker_processes: 1
    - require:
      - pkg: nginx

/etc/nginx/mime.types:
  file.managed:
    - source: salt://nginx/etc/nginx/mime.types
    - require:
      - pkg: nginx

/etc/nginx/conf.d:
  file.directory:
    - require:
      - pkg: nginx

/etc/nginx/sites-available:
  file.directory:
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled:
  file.directory:
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file.absent

/srv/www:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 750

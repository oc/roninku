roninku:
  - name: example
    user: www-data
    group: www-data
    user_home: /var/www
    post_receive:
      target: /srv/www/example.com
      settings:
        foreman:
          provider: supervisord
          portbase: 5001
          scale: web=1 workers=1
    deployers:
      - id: oc

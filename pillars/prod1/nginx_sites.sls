nginx_sites:
  - fqdn: example.com
    aliases:
      - www.example.com
    default: true
    root: /srv/www/example.com
    upstreams: ["localhost:5001"]
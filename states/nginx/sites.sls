include:
  - nginx

{% for site in pillar['nginx_sites'] %}
/etc/nginx/sites-available/{{ site.fqdn }}.conf:
  file.managed:
    - source: salt://nginx/etc/nginx/conf.d/site.conf.jinja
    - template: jinja
    - defaults:
        fqdn: {{ site.fqdn }}
        ssl: {{ site.ssl or False }}
        root: {{ site.root }}
        default: {{ site.default or False }}
        autoindex: {{ site.autoindex or False }}
        static_prefix: {{ site.static_prefix or False }}
        aliases: {{ site.aliases or [] }}
        subdomain_to_path_alias: {{ site.subdomain_to_path_alias or False }}
        upstream_location: {{ site.upstream_location or "/" }}
        upstreams: {{ site.upstreams or [] }}
        php_upstreams: {{ site.php_upstreams or [] }}
        append_html_to_path: {{ site.append_html_to_path or False }}

/etc/nginx/sites-enabled/{{ site.fqdn }}.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ site.fqdn }}.conf
    - require:
      - file: /etc/nginx/sites-available/{{ site.fqdn }}.conf
{%- if site.ssl %}
/etc/ssl/certs/{{ site.fqdn }}.crt:
  file.managed:
    - source: salt://nginx/ssl-certs/{{ site.fqdn }}.crt
    - mode: 644
/etc/ssl/private/{{ site.fqdn }}.key:
  file.managed:
    - source: salt://nginx/ssl-certs/{{ site.fqdn }}.key
    - mode: 640
{%- endif %}
{%- if site.root %}
{{ site.root }}:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 775
    - makedirs: True
    - recurse:
      - group
{%- endif %}
{% endfor %}

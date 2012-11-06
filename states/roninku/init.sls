#
# roninku - salt-imitation of heroku
#
roninku-pkgs:
  pkg.installed:
    - names:
      - git
      - supervisor

include:
  - rvm
  - foreman

##
## Set up user to run roninku as (i.e. git, www-data, etc)
##
{% for repo in pillar['roninku'] %}
{{ repo.user }}:
  user.present:
    - home: {{ repo.user_home }}
    - gid: {{ repo.group }}
{{ repo.user_home }}:
  file.directory:
    - user: {{ repo.user }}
    - group: {{ repo.group }}
    - mode: 750
    - makedirs: True
    - require:
      - user: {{ repo.user }}
{{ repo.user_home }}/.ssh:
  file.directory:
    - user: {{ repo.user }}
    - group: {{ repo.group }}
    - mode: 700
    - makedirs: True
    - require:
      - file: {{ repo.user_home }}
##
## Manage the ssh-pubkeys in a salt-state salt
##
{% for deployer in repo.get('deployers', []) %}
grant-repo-{{ repo.name }}-{{ deployer.id }}:
  ssh_auth:
    - present
    - user: {{ repo.user }}
    - source: salt://ssh-keys/{{ deployer.id }}.id_rsa.pub
    - require:
      - file: {{ repo.user_home }}/.ssh
{% endfor %}
##
## Create git repo
##
/var/git/{{ repo.name }}:
  file.directory:
    - name: /var/git/{{ repo.name }}.git
    - user: {{ repo.user }}
    - group: {{ repo.user }}
    - mode: 750
    - makedirs: True
    - require:
      - user: {{ repo.user }}

##
## Create log path (for foreman)
##
/var/log/{{ repo.name }}:
  file.directory:
    - user: {{ repo.user }}
    - group: {{ repo.user }}
    - mode: 750
    - makedirs: True
    - require:
      - user: {{ repo.user }}

##
## Init the repo unless it already exists
##
git-init-{{ repo.name }}:
  cmd.run:
    - name: git init --bare /var/git/{{ repo.name }}.git
    - unless: ls /var/git/{{ repo.name }}.git/config
    - user: {{ repo.user }}
    - group: {{ repo.user }}
    - cwd: {{ repo.user_home }}
    - shell: /bin/bash
    - require:
      - pkg: git
      - file: /var/git/{{ repo.name }}.git
##
## Setup the post-receive hook.
##
## TODO: execjar
##
{%- if repo.post_receive %}
/var/git/{{ repo.name }}.git/hooks/post-receive:
  file.managed:
    - source: salt://roninku/hooks/ruby-post-receive.jinja
    - template: jinja
    - user: {{ repo.user }}
    - group: {{ repo.group }}
    - mode: 750
    - context: {{ repo.post_receive }}
    - defaults:
        appname: {{ repo.name }}
        user: {{ repo.user }}
        group: {{ repo.group }}
        type: ruby
        settings: {}
        target: /srv/www/{{ repo.name }}
    - require:
      - cmd: git-init-{{ repo.name }}
      - pkg: supervisor
      - gem: foreman
{%- endif %}
{% endfor %}
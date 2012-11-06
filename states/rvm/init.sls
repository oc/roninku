rvm-deps:
  pkg.installed:
    - names:
      - bash
      - coreutils
      - gzip
      - bzip2
      - gawk
      - sed
      - curl
      - git-core
      - subversion
      - sudo

mri-deps:
  pkg.installed:
    - names:
      - build-essential
      - openssl
      - libreadline6
      - libreadline6-dev
      - curl
      - git-core
      - zlib1g
      - zlib1g-dev
      - libssl-dev
      - libyaml-dev
      - libsqlite3-0
      - libsqlite3-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - autoconf
      - libc6-dev
      - libncurses5-dev
      - automake
      - libtool
      - bison
      - subversion
      - ruby

#jruby-deps:
#  pkg.installed:
#    - names:
#      - curl
#      - g++
#      - oracle-java7-installer

ruby-1.9.2:
  rvm.installed:
    - default: True
    - require:
      - pkg: rvm-deps
      - pkg: mri-deps

ruby-1.9.3:
  rvm.installed:
    - default: True
    - require:
      - pkg: rvm-deps
      - pkg: mri-deps
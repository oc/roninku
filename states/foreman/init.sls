include:
  - rvm

global:
  rvm.gemset_present:
    - ruby: ruby-1.9.2
    - require:
        - rvm: ruby-1.9.2
  rvm.gemset_present:
    - ruby: ruby-1.9.3
    - require:
        - rvm: ruby-1.9.3

foreman:
  gem.installed:
    - ruby: ruby-1.9.2@global
  gem.installed:
    - ruby: ruby-1.9.3@global
README
======

Basically a full example. Just extract to your salt-base, and
config master something like:

   file_roots:
     base:
       - /srv/salt/states

   pillar_roots:
     base:
       - /srv/salt/pillars

# Update pillar data:

  salt '*' saltutil.refresh_pillar

# Update to highstate:

  salt '*' state.highstate

That's it.

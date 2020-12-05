## discourse-selfish-seo-layout-changes 

This simple Discourse plugin makes some selfish changes to the Discourse layout.  We originally made the changed to Discourse with pups during the container build process but have moved this to plugin.

## Discourse Layout Changes

### layouts/_head.html.erb

- Removes canonical meta link (because we want Google to decide canonical since we migrated topics over from the legacy site)
- Removes generator meta link (because we do not want to show the generator for a number of reasons)

### layouts/crawler.html.erb

- Changes the powered-by link to point to our legacy site instead of Discourse (selfishly).
- Adds our google-site-verification meta tag

### layouts/application.html.erb

- Changes the powered-by link to point to our legacy site instead of Discourse (selfishly).

## TODO

- Add Discourse site settings to:
  - Turn on and off this plugin/
  - Add custom google-site-verification value.
  - Site settings to enable / disable each layout change.

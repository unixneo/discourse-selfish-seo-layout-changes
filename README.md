## discourse-selfish-seo-layout-changes 

This simple Discourse plugin makes a few "selfish" changes to the Discourse layout.  

## Discourse Layout Changes

### layouts/_head.html.erb

- Removes canonical meta link (because we want Google to decide canonical since we migrated topics over from the legacy site)
- Removes generator meta link (because we do not want to show the generator for a number of reasons)

### layouts/crawler.html.erb

- Changes the powered-by link to point to our legacy site instead of Discourse (selfishly).
- Adds our google-site-verification meta tag

### layouts/application.html.erb

- Changes the powered-by link to point to our legacy site instead of Discourse (selfishly).

### meta description content

- Strips newlines and excessive white space from meta descriptions by monkey patching the TopicsController.

### templates/application.hbs

- Strips out the PWA code in the application (moved to standalone plugin)

## TODO

- Add Discourse site settings to:
  - Turn on and off this plugin.
  - Add custom google-site-verification value.
  - Site settings to enable and disable each layout change.

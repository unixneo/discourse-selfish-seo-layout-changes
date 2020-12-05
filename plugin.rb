# frozen_string_literal: true

# name: discourse-selfish-seo-layout-changes
# about: selfish plugin to remove canonical url, generator and change powered by, etc.
# version: 0.0.21
# date: 5 December 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-selfish-seo-layout-changes

PLUGIN_NAME = "discourse-selfish-seo-layout-changes"
APP_ROOT = "#{Rails.root}/plugins/#{PLUGIN_NAME}/app"
PLUGIN_LOGIC = "#{APP_ROOT}/lib/selfish_layout_changes.rb"
load File.open(PLUGIN_LOGIC)

after_initialize do
  SelfishSeoLayoutChanges.modify_head_layout
  SelfishSeoLayoutChanges.modify_crawler_layout
  SelfishSeoLayoutChanges.modify_application_layout
end

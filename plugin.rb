# frozen_string_literal: true

# name: discourse-selfish-seo-layout-changes
# about: selfish plugin to remove canonical url, generator and change powered by, etc.
# version: 0.0.33
# date: 5 December 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-selfish-seo-layout-changes

PLUGIN_NAME = "discourse-selfish-seo-layout-changes"
#APP_ROOT = "#{Rails.root}/plugins/#{PLUGIN_NAME}/app"
#PLUGIN_LOGIC = "#{APP_ROOT}/lib/selfish_layout_changes.rb"
#load File.open(PLUGIN_LOGIC)
load File.expand_path("app/lib/selfish_layout_changes.rb", __FILE__)
#MONKEY_PATCH = "#{APP_ROOT}/lib/monkey_patch_topics_controller.rb"

after_initialize do
  SelfishSeoLayoutChanges.modify_head_layout
  SelfishSeoLayoutChanges.modify_crawler_layout
  SelfishSeoLayoutChanges.modify_application_layout

  load File.open("app/lib/monkey_patch_topics_controller.rb", __FILE_)
end

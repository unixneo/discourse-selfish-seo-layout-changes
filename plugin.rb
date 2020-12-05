# frozen_string_literal: true

# name: discourse-selfish-seo-layout-changes
# about: selfish plugin to remove canonical url, generator and change powered by, etc.
# version: 0.0.294
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

  TopicsController.class_eval do
    before_action :strip_newlines_and_more_from_meta_description, on: [:perform_show_response]

    private

    def strip_newlines_and_more_from_meta_description
      Discourse.warn(">>>>NEONEO_BEGIN>>>>> @description_meta: #{@topic_view.topic.excerpt}", uri: request.env["REQUEST_URI"])
      tmp_description = @topic_view.topic.excerpt&.dup
      tmp_description = tmp_description&.gsub("&amp;hellip;", "")
      tmp_description = tmp_description&.gsub("&hellip;")
      tmp_description = tmp_description&.gsub(/\n+/, " ")
      tmp_description = tmp_description&.gsub(/\s+/, " ")&.strip
      @topic_view.topic.excerpt = tmp_description
      Discourse.warn(">>>>NEONEO_END>>>>> @description_meta: #{@topic_view.topic.excerpt}", uri: request.env["REQUEST_URI"])
    end
  end
end

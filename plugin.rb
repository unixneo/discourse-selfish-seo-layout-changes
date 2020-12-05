# frozen_string_literal: true

# name: discourse-selfish-seo-layout-changes
# about: selfish plugin to remove canonical url, generator and change powered by, etc.
# version: 0.0.298
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

  # overwrite TopicsController private method to clean up @description_meta text
  class TopicsController
    def perform_show_response
      if request.head?
        head :ok
        return
      end

      topic_view_serializer = TopicViewSerializer.new(
        @topic_view,
        scope: guardian,
        root: false,
        include_raw: !!params[:include_raw],
      )

      respond_to do |format|
        format.html do
          @tags = SiteSetting.tagging_enabled ? @topic_view.topic.tags : []
          @breadcrumbs = helpers.categories_breadcrumb(@topic_view.topic) || []
          @description_meta = @topic_view.topic.excerpt.present? ? @topic_view.topic.excerpt : @topic_view.summary
          @description_meta = @description_meta&.gsub("&amp;hellip;", "")
          @description_meta = @description_meta&.gsub("&hellip;", "")
          @description_meta = @description_meta&.gsub(/\n+/, " ")
          @description_meta = @description_meta&.gsub(/\s+/, " ")&.strip
          store_preloaded("topic_#{@topic_view.topic.id}", MultiJson.dump(topic_view_serializer))
          render :show
        end

        format.json do
          render_json_dump(topic_view_serializer)
        end
      end
    end
  end
end

TopicsController.class_eval do
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
        @description_meta = @description_meta&.gsub("&amp;hellip;", " ")
        @description_meta = @description_meta&.gsub("&hellip;", " ")
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

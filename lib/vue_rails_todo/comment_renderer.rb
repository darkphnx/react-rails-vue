module VueRailsTodo
  # Takes a plain-text comment and turns it into HTML by passing it through a
  # markdown parser etc.
  module CommentRenderer
    # This list will be used in order to render the text
    RENDER_PIPELINE = [
      VueRailsTodo::CommentRenderer::SpaceFacts,
      VueRailsTodo::CommentRenderer::Markdown
    ].freeze

    # Process a string through each stage of the render pipeline.
    #
    # @param text [String] Raw text to be passed through the pipeline
    #
    # @return [Strig] Fully rendered text
    def self.render(text)
      output = text.dup

      RENDER_PIPELINE.each do |render_stage|
        renderer = render_stage.new
        output = renderer.render(output)
      end

      output
    end
  end
end

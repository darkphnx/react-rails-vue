module VueRailsTodo
  module CommentRenderer
    RENDER_PIPELINE = [
      VueRailsTodo::CommentRenderer::SpaceFacts,
      VueRailsTodo::CommentRenderer::Markdown
    ].freeze

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

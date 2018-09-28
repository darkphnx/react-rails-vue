module VueRailsTodo
  module CommentRenderer
    # Use the Redcarpet markdown renderer to transform text.
    class Markdown < Base
      # Process the text through a markdown parser
      #
      # @param text [String] Raw text, possibly with markdown attributes
      #
      # @return [String] HTML text, after markdown processing
      def render(text)
        parser.render(text)
      end

      private

      # The markdown parser, with some sensible extensions
      def parser
        @parser ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, autolink: true)
      end

      # The output format used by Redcarpet, with some sensible defaults
      def renderer
        @renderer ||= Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
      end
    end
  end
end

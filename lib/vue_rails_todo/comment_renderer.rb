module VueRailsTodo
  class CommentRenderer
    def initialize
    end

    def render(text)
      parser.render(text)
    end

    private

    def parser
      @parser ||= Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, autolink: true)
    end

    def renderer
      @renderer ||= Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    end
  end
end

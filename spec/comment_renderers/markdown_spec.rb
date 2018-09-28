require 'rails_helper'

RSpec.describe VueRailsTodo::CommentRenderer::Markdown do
  describe '#render' do
    it 'Transforms markdown into HTML' do
      renderer = described_class.new

      markdown = <<~MARKDOWN
        **bold text**
        _italic text_
      MARKDOWN

      expected_html = <<~HTML
        <p><strong>bold text</strong><br>
        <em>italic text</em></p>
      HTML

      expect(renderer.render(markdown)).to eq(expected_html)
    end
  end
end

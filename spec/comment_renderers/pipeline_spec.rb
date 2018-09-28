require 'rails_helper'

RSpec.describe VueRailsTodo::CommentRenderer do
  describe '.render' do
    it 'calls each #render on each renderer in the list' do
      described_class::RENDER_PIPELINE.each do |renderer_klass|
        expect_any_instance_of(renderer_klass).to receive(:render)
      end

      described_class.render('')
    end

    it 'returns output passed through multiple renderers' do
      # We'll pass some text that should be caught by SpaceFact and Markdown renderers

      raw_text = "**![fact]**"
      expected_html = %r{<p><strong>(.+?)</strong></p>}

      rendered_text = described_class.render(raw_text)

      # Because we haven't tested for the presence of a precise fact we'll just ensure
      # that ![fact] has been removed
      expect(rendered_text).to_not include('![fact]')
      expect(rendered_text).to match(expected_html)
    end
  end
end

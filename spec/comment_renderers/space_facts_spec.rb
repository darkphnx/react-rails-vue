require 'rails_helper'

RSpec.describe VueRailsTodo::CommentRenderer::SpaceFacts do
  describe '.space_facts_path' do
    it 'points to db/space_facts.txt' do
      expect(described_class.space_facts_path).to eq(facts_path)
    end
  end

  describe '.space_facts' do
    it 'returns an array of space facts loaded from .space_facts_path' do
      expect(described_class.space_facts).to eq(facts_list)
    end
  end

  describe '#render' do
    it 'replaces ![fact] with a random space fact' do
      renderer = described_class.new
      rendered_text = renderer.render('![fact]')

      expect(facts_list).to include(rendered_text)
    end
  end

  def facts_list
    File.read(facts_path).split("\n")
  end

  def facts_path
    Rails.root.join('db', 'space_facts.txt')
  end
end

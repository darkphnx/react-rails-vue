# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  context 'callbacks' do
    it 'creates or finds a Tag record for each entry in comma separated tags_list' do
      # An existing Tag to be found
      existing_tag = Tag.create(title: 'pet')

      task = Task.create(title: 'feed the dog', tags_list: 'pet, food')

      expect(task.tags.size).to eq(2)
      expect(task.tags[0].id).to eq(existing_tag.id)
      expect(task.tags[0].title).to eq(existing_tag.title)
      expect(task.tags[1].title).to eq('food')
    end
  end
end

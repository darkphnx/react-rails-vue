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
end

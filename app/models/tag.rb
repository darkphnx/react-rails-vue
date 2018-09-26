# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :tasks_tags, dependent: :destroy
  has_many :tasks, through: :tasks_tags

  validates :title, presence: true
end

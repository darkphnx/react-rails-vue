# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Task < ApplicationRecord
  has_many :tasks_tags, dependent: :destroy
  has_many :tags, through: :tasks_tags

  validates :title, presence: true
end

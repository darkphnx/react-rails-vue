class Tag < ApplicationRecord
  has_many :tasks_tags, dependent: :destroy
  has_many :tasks, through: :tasks_tags
end

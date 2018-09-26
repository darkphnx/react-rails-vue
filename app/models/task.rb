class Task < ApplicationRecord
  has_many :tasks_tags, dependent: :destroy
  has_many :tags, through: :tasks_tags
end

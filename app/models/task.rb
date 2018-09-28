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
  # Pass a comma separated list of tags into here and tags will be set
  attr_accessor :tags_list

  # Regex that splits tags by comma and consumes whitespace
  TAGS_LIST_SPLIT = /\s*,\s*/

  has_many :tasks_tags, dependent: :destroy
  has_many :tags, through: :tasks_tags
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  before_save :process_tags_list

  scope :asc, -> { order(id: :asc) }

  private

  # If tags_list is set, update the tag relationship to reflect what's in that list.
  def process_tags_list
    return unless tags_list

    # Split the tag list and ensure there's no duplicates
    tag_titles = tags_list.split(TAGS_LIST_SPLIT).uniq

    # Find or create a Tag model for each tag_title
    tag_models = tag_titles.map do |tag_title|
      Tag.find_or_create_by(title: tag_title)
    end

    # Set the relationship to the found/created tags
    self.tags = tag_models
  end
end

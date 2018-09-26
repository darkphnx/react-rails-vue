# == Schema Information
#
# Table name: tasks_tags
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  tags_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# You could get away with this being a simple HABTM relationship on tasks and
# tags, but I find you always need the link model eventually.
class TasksTag < ApplicationRecord
  belongs_to :task
  belongs_to :tag
end

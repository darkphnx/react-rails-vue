# You could get away with this being a simple HABTM relationship on tasks and
# tags, but I find you always need the link model eventually.
class TasksTag < ApplicationRecord
  belongs_to :task
  belongs_to :tags
end

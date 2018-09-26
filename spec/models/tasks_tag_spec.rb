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

require 'rails_helper'

RSpec.describe TasksTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

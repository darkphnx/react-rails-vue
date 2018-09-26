# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :task
end

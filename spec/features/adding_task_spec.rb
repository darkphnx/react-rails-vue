require 'rails_helper'

RSpec.feature "Adding a task" do
  scenario "User fills in a title and tags" do
    visit root_path

    task_title = "Walk the dog"
    task_tags = "pet, exercise"

    within('#new_task_form') do
      fill_in 'task_title', with: task_title
      fill_in 'task_tags_list', with: task_tags
    end

    click_on "Add Task"

    within('.task') do
      expect(page).to have_text(task_title)
      task_tags.split(', ').each do |tag|
        expect(page).to have_text(tag)
      end
    end

    expect(find_field('task_title').value).to eq('')
    expect(find_field('task_tags_list').value).to eq('')
  end
end

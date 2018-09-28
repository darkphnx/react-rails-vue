require 'rails_helper'

RSpec.feature "Deleting task" do
  scenario "User clicks the delete button on a task" do
    @task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')

    visit root_path

    within('.task') do
      click_on "Delete"
    end

    expect(page).not_to have_text('Walk the dog')
  end
end

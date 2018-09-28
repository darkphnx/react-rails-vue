require 'rails_helper'

RSpec.feature "Tag filtering" do
  scenario "User clicks a tag show only tasks with that tag" do
    @matching_task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')
    @nonmatching_task = Task.create(title: "Walk the cat", tags_list: 'pet, mental')

    visit root_path

    within('#tag_filter') do
      click_on 'exercise'
    end

    expect(page).to have_text(@matching_task.title)
    expect(page).not_to have_text(@nonmatching_task.title)
  end

  scenario "User clicks a All Tags to show all tasks" do
    @task_one = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')
    @task_two = Task.create(title: "Walk the cat", tags_list: 'pet, mental')

    visit root_path

    within('#tag_filter') do
      click_on 'All Tags'
    end

    expect(page).to have_text(@task_one.title)
    expect(page).to have_text(@task_two.title)

  end
end

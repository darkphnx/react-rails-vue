require 'rails_helper'

RSpec.feature "Editing task" do
  scenario "User clicks edit button on task to show the fields" do
    @task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')

    visit root_path

    within('.task') do
      click_on "Edit"
    end

    expect(page).to have_field('edit_task_title')
    expect(page).to have_field('edit_task_tags_list')
  end

  scenario "User clicks edit, but changes their mind" do
    @task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')

    visit root_path

    within('.task') do
      click_on "Edit"
      click_on "Cancel"
    end

    expect(page).to_not have_field('edit_task_title')
    expect(page).to_not have_field('edit_task_tags_list')
  end

  scenario "User changes task properties" do
    @task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')

    visit root_path

    new_title = "Walk the dog again"
    new_tags = "pet, walking"

    within('.task') do
      click_on "Edit"
      fill_in 'edit_task_title', with: new_title
      fill_in 'edit_task_tags_list', with: new_tags

      click_on 'Save'

      expect(page).to have_text(new_title)
      new_tags.split(', ').each do |tag|
        expect(page).to have_text(tag)
      end
    end
  end
end

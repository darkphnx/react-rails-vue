require 'rails_helper'

RSpec.feature "Adding a comment" do
  scenario "User tyes a comment" do
    @task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')

    visit root_path

    comment_body = "I love walking the dog"

    within('#new_comment_form') do
      fill_in 'comment_body', with: comment_body
      click_on "Post Comment"
    end

    expect(page).to have_text(comment_body)
    expect(find_field('comment_body').value).to eq('')
  end

  scenario "User doesn't enter comment text" do
    @task = Task.create(title: "Walk the dog", tags_list: 'pet, exercise')

    visit root_path

    within('#new_comment_form') do
      click_on "Post Comment"
    end

    expect(page).to have_text "Sorry, couldn't save that comment, the following errors occurred:"
    expect(page).to have_text "Body"
  end
end

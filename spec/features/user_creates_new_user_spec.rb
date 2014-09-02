require "rails_helper"

feature "user creates, edits and deletes a user" do
  scenario "creating a new user with valid first name, last name and email address" do
    visit new_user_path
    fill_in "First Name", with: "Tommy"
    fill_in "Last Name", with: "Wiseau"
    fill_in "Email", with: "tommy@theroom.com"
    click_button "Create"
    expect(page).to have_content "Tommy Wiseau"
  end

  scenario "editing a user" do
    john = Fabricate(:user, email: "john@example.com")
    visit users_path
    click_link "Edit User"

    fill_in "Email", with: "johnny@example.com"
    click_button "Update"
    expect(page).to have_content "johnny@example.com"
  end

  scenario "deleting a user" do
    sally = Fabricate(:user)
    visit users_path
    click_link "Delete User"
    expect(page).to_not have_content sally.first_name 
  end
end
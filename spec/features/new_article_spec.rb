require "spec_helper"

feature "New Article" do
    # As a slacker
    # I want to be able to submit an incredibly interesting article
    # So that other slackers may benefit from my distraction

    # Acceptance Criteria:

    # When I visit '/articles/new' it should have a form to submit a new article
    # the form accepts article title, url, and description
    # when I successfully post an article, it should save to a CSV file
    # if I try to submit an empty form, stay on the page, nothing is saved to CSV file

  before(:each) do
    visit '/articles/new'
  end

  scenario "user should see the new article page at '/article/new'" do
    expect(page).to have_content("Contribute to Articles for Procrastinators!")
  end

  scenario "user can enter a title, description, and url" do
    expect(page).to have_field("Title:")
    expect(page).to have_field("Description:")
    expect(page).to have_field("Url:")
    expect(page).to have_button("Submit")
  end

  scenario "if a form is complete, user is redirected to main page, and article is saved to CSV" do
    fill_in "Title:", :with => 'Woo Unicorns!'
    fill_in "Description:", :with => 'This is a new description that is more than 20 characters long'
    fill_in "Url:", :with => 'http://notarealsite'
    click_button("Submit")

    expect(page).to have_content("Articles for Procrastinators!")
    expect(page).to have_content('Woo Unicorns!')
    expect(page).to have_content('This is a new description that is more than 20 characters long')
    expect(page).to have_link('http://notarealsite')
  end

  scenario "if a blank form is submitted, an error will appear" do
    click_button("Submit")

    expect(page).to have_content("Please complete the form and don't procrastinate!")
    expect(page).to have_content("Contribute to Articles for Procrastinators!")
  end
end

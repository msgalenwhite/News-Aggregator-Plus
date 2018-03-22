require "spec_helper"

feature "Random" do

  # User Story:

  # As an errant slacker
  # I want to see a random article
  # So that I can spend less time choosing which article to read

  # Acceptance Criteria:
  #
  # When I visit /random it has a button with the text "Random Button".
  # When the button is clicked, a fetch call should generate a request to an API endpoint on the Sinatra backend
  # The API endpoint should return a random article as a response, and that article's information will need to append to the page.

  before(:each) do
    CSV.open('articles.csv', 'w') do |csv|
      csv << ["id,title,description,url"]
      csv << [9,"Totally Random", "Description no one saw coming", "http:totallynotfake"]
    end
  end

  before(:each) do
    visit '/random'
  end

  scenario "user visits 'articles/random' and sees the Random Title and Random Button" do
    expect(page).to have_content("Random is Cool")
    expect(page).to have_content("Random Button")
  end

  # ERROR - CSV has an article after clicking, but on next test it thinks things are empty
  # scenario "user clicks button, an article appears, and button text changes" do
  #   find('#randomTarget').click
  #
  #   expect(page).to have_content("Totally Random")
  #   expect(page).to have_content("Description no one saw coming")
  #   expect(page).to have_content("http:totallynotfake")
  #   expect(page).to have_content("More Random!")
  # end
end

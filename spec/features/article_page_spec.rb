require "spec_helper"

feature "Articles Page" do
  #   As a user,
  #   I want to visit a page
  #   and view all submitted articles
  #
  # Acceptance Criteria:
  #
  # When I visit '/articles' I should see all of the submitted Articles
  # Each Article shows the description, title, and url
  # If I click the url, it takes me to the relevant page in a new tab
  # If I click the article's title, I go to the Article's page
  # If there are no articles yet, display message

  fake_articles = [
    [1,"Titles are cool","descriptions are cooler","http://urlsarethebest"],
    [2,"Unicorns are Awesome","We always love unicorns for examples.","http://www.google.com]"],
    [3,"Unicorn2","Whoa","http://urls are the best"],
    [4, "Sample Title", "Sample Description", "SampleURL for Capybara"]
  ]

  before(:all) do
    CSV.open('articles.csv', 'a') do |csv|
      fake_articles.each do |fake_article|
        csv << fake_article
      end
    end
  end

  before(:each) do
    visit '/articles'
  end

  scenario "user should see the articles page when going to '/articles'" do
    expect(page).to have_content("Articles for Procrastinators!")
  end

  scenario "user should see all articles on '/articles'" do
    expect(page).to have_content("Titles are cool")
    expect(page).to have_content("Unicorns are Awesome")
    expect(page).to have_content("Unicorn2")
  end

  scenario "each article shows the description, title and a url link" do
    expect(page).to have_content("Sample Title")
    expect(page).to have_content("Sample Description")
    expect(page).to have_link("SampleURL for Capybara")
    expect(find_link('http://www.google.com')[:target]).to eq('_blank')
  end

  scenario "user can click an article's url and be taken to the correct site in a new tab" do
    click_link ("Unicorns are Awesome")

    expect(page).not_to have_content("Sample Title")
    expect(page).to have_link("Back to Main")
  end

  scenario "when clicking the 'Add Something New' button, user should be taken to the form" do
    click_link('Add Something New!')

    expect(page).to have_content("Contribute to Articles for Procrastinators!")
  end

  # scenario "no articles have been submitted yet, user should get a message" do
  #   CSV.open('articles.csv', 'w') { |file| file.puts(["id,title,description,url"]) }
  #
  #   expect(page).to have_content("No submissions yet - better enter something new.")
  # end
end

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'pry'
require 'csv'
require 'launchy'

require_relative '../server'
require_relative '../models/article'



RSpec.configure do |config|
  config.before(:suite) do
    CSV.open('articles.csv', 'w') { |file| file.puts(["id","title","description","url"]) }
  end

  config.after(:suite) do
    CSV.open('articles.csv', 'w') { |file| file.puts(["id,title,description,url"]) }
  end
end
Capybara.app = Sinatra::Application

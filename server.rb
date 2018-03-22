require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'csv'
require 'json'

require_relative 'models/article'

set :bind, '0.0.0.0'

def submitted_urls
  url_array = []
  CSV.foreach('articles.csv', headers:true) do |row|
    url_array << row[:url]
  end
  url_array
end

def write_article_to_csv(data)
  CSV.open('articles.csv', 'a') do |csv|
    csv << data
  end
end

### 'GET' API ENDPOINTS

get '/' do
  redirect '/articles'
end

get '/articles' do
  @articles = []

  CSV.foreach('articles.csv', headers: true) do |row|
    @articles << Article.new(row["id"], row["title"], row["description"], row["url"])
  end

  erb :articles
end

get '/articles/new' do
  erb :new_article
end

get '/random' do
  erb :random
end

get '/api/v1/articles/random' do
  article_array = CSV.read('articles.csv')
  article_array.shift
  random = article_array.sample

  JSON.generate(random)

  # alternatively:
  #
  # get "/random_article.json" do
  #   content_type :json
  #
  #   # Your ruby code that pulls an a random article from your CSV file.
  #
  #   status 200
  #   books.to_json
  # end
end

get '/articles/individual/:id' do
  @article_id = params[:id]

  CSV.foreach('articles.csv', headers: true) do |row|
    binding.pry
    if row["id"] === @article_id
      @article_title = row["title"]
      @article_description = row["description"]
      @article_url = row["url"]
    end
  end
  erb :indiv_article
end

errorHash = {
  incompleteForm: "Please complete the form and don't procrastinate!",
  wrongUrl: "Please enter a valid url! (starting with 'http')",
  shortDescription: "We all know your article is longer than that.",
  copyArticle: "Copycat!  Enter a unique url (please)"
}

### 'POST' API ENDPOINTS

post '/articles/new' do
  @title = params[:article_title]
  @description = params[:article_description]
  @url = params[:article_url]
  url_array = submitted_urls
  new_id = url_array.length + 1

  if @title == "" || @description == "" || @url == ""
    @error = "Please complete the form and don't procrastinate!"

    erb :new_article
  elsif @url[0..3] != "http"
    @error = "Please enter a valid url! (starting with 'http')"

    erb :new_article
  elsif @description.length <= 20
    @error = "We all know your article is longer than that."

    erb :new_article
  elsif submitted_urls.include?(@url)
    @error = "Copycat!  Enter a unique url (please)"

    erb :new_article
  else
    write_article_to_csv([new_id, @title, @description, @url])

    redirect '/articles'
  end
end

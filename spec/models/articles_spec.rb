require 'spec_helper'

RSpec.describe "Article" do
  let(:sample_article) { Article.new(3, "Title", "Description", "Url") }

  describe "#initialize" do
    it "takes in id, title, description and url and has readers for them" do

      expect(sample_article.id).to eq(3)
      expect(sample_article.title).to eq("Title")
      expect(sample_article.description).to eq("Description")
      expect(sample_article.url).to eq("Url")
    end
  end
end

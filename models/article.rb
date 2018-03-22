class Article
  attr_reader :title, :description, :url, :id

  def initialize(id, title, description, url)
    @id = id
    @title = title
    @description = description
    @url = url
  end
end

class KdnuggetsRoundup::Article

  attr_accessor :title, :author, :tags, :url, :summary, :sample
  @@all = []
  @@popular = [] #=> contains most popular articles for easy filtering
  @@shared = [] #=> contains most shared articles for same reason

  def initialize(title)
    @title = title
    @@all << self
  end

  def add_to_popular
    @@popular << self
  end

  def add_to_shared
    @@shared << self
  end

  def self.popular
    @@popular
  end

  def self.shared
    @@shared
  end

  def self.all
    @@all
  end

  def self.list(collection)
    collection.each_with_index do |article, i|
      puts "#{i + 1}. #{article.title}"
    end
  end

end

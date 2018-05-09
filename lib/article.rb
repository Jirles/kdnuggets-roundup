class KdnuggetsRoundup::Article

  attr_accessor :title, :author, :tags, :url, :summary, :excerpt 
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

  def display_article
    puts <<-DOC
    #{title}
    By: #{author}
    Tags: #{tags.dup.join(', ')}

    Summary
    -------
    #{summary}
    DOC
  end

  def read_excerpt
    puts "Howdy! I'm Annie Oakley and today we're going to be talking about Python."
  end

end

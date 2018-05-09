class KdnuggetsRoundup::Article

  attr_accessor :title, :author, :tags, :url, :summary, :sample
  @@all = []
  @@popular = [] #=> contains most popular articles for easy filtering
  @@shared = [] #=> contains most shared articles for same reason

  def initialize(title)
    @title = title
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_all
    puts '' #=> ensures space between entry and titles
    all.each_with_index do |article, i|
      puts "#{i + 1}. #{article.title}"
    end
    puts "* * * * * * * * *"
  end

end

class KdnuggetsRoundup::Article

  attr_accessor :title, :author, :tags, :url, :summary, :excerpt, :popular, :shared
  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
    @popular = false
    @shared = false
    @@all << self
  end

  def assign_attributes(attribute_hash)
    attribute_hash.each{|k, v| self.send("#{k}=", v)}
  end

  def self.find_by_title(title)
    all.detect{|story| story.title == title}
  end

  def add_to_popular
    @popular = true
  end

  def add_to_shared
    @shared = true
  end

  def self.popular
    all.select{|a| a.popular}
  end

  def self.shared
    all.select{|a| a.shared}
  end

  def self.all
    @@all
  end

end

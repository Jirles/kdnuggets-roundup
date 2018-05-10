require 'nokogiri'
require 'open-uri'
require 'pry'

class KdnuggetsRoundup::DataWrassler
  #web scraper class

  BASE_URL = 'https://www.kdnuggets.com'
  TOP_STORIES_PATH = '/news/top-stories.html'

  def wrassle_top_stories #=> Note there are 7 stories in both most popular and most shared each week
    doc = Nokogiri::HTML(open(BASE_URL + TOP_STORIES_PATH))
    stories = doc.css('ol.three_ol li')
    counter = 0
    stories.each do |story|
      counter += 1
      url = BASE_URL + story.css('a').attribute('href').text
      title = story.css('b').text
      if KdnuggetsRoundup::Article.find_by_title(title)
        article = KdnuggetsRoundup::Article.find_by_title(title)
      else
        article = KdnuggetsRoundup::Article.new(title, url)
        article.assign_attributes(wrassle_article_attributes(url))
      end
      counter < 8 ? article.add_to_popular : article.add_to_shared
    end
  end

  def wrassle_article_attributes(article_url)
    #helper method to be called inside wrassle_top_stories
    doc = Nokogiri::HTML(open(article_url))
    tags = doc.css('div.tag-data a')
    tags = tags.collect{|tag| tag.text}
    summary = doc.css('p.excerpt').text
    author = doc.css('#post- b').text.match(/\S*\s\S*[[:punct:]]/)[0].gsub(/[0-9[[:punct:]]]/, '')
    article = doc.css('p, ol, ul')
    counter = 0
    excerpt = []
    article.each do |paragraph|
      counter += 1
      if counter < 3 #=> first two elements are normally
        next
      elsif counter > 8 #=> ensures only 5 elements make it through
        break
      end
      excerpt << paragraph.text
      #binding.pry
    end
    excerpt = excerpt.delete_if{|x| x ==''}
    {author: author, tags: tags, summary: summary, excerpt: excerpt}
  end
end

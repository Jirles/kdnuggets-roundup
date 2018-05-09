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
      url = story.css('a').attribute('href').text
      title = story.css('b').text
      article = KdnuggetsRoundup::Article.new(title, url)
      counter < 8 ? article.add_to_popular : article.add_to_shared
      wrassle_article_attributes(article, url)
      binding.pry
    end
  end

  def wrassle_article_attributes(article, article_url)
    #helper method to be called inside wrassle_top_stories
    doc = Nokogiri::HTML(open(BASE_URL + article_url))
    tags = doc.css('div.tag-data a')
    Array.new.tap |tags|
      tags.each do |tag|
        tags << tag
      end
    end
    excerpt = doc.css('p.excerpt').text
  end

end

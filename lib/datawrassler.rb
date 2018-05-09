require 'nokogiri'
require 'open-uri'
require 'pry'

class KdnuggetsRoundup::DataWrassler
  #web scraper class

  BASE_URL = 'https://www.kdnuggets.com'
  TOP_STORIES_PATH = '/news/top-stories.html'

  def wrassle_top_titles_urls #=> Note there are 7 stories in both most popular and most shared each week
    doc = Nokogiri::HTML(open(BASE_URL + TOP_STORIES_PATH))
    stories = doc.css('ol.three_ol li')
    counter = 0
    stories.each do |story|
      counter += 1
      url = story.css('a').attribute('href').text
      title = story.css('b').text
      article = KdnuggetsRoundup::Article.new(title, url)
      counter < 8 ? article.add_to_popular : article.add_to_shared
    end
  end

end

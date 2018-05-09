require 'nokogiri'
require 'open-uri'
require 'pry'

class KdnuggetsRoundup::DataWrassler
  #web scraper class

  BASE_URL = 'https://www.kdnuggets.com'
  TOP_STORIES_PATH = '/news/top-stories.html'

  def wrassle_top_stories
    doc = Nokogiri::HTML(open(BASE_URL + TOP_STORIES_PATH))
    first_pop_title = doc.css('div.post-49857 h3').first.text
    binding.pry 
  end

end

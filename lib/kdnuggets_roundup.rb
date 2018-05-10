require "kdnuggets_roundup/version"
require "datawrassler"
require "article"
require 'pry'

module KdnuggetsRoundup

  class RoundupCLI
    #formatting methods
    def breakline_space_only
      puts ""
    end

    def breakline_title
      puts ". . ."
      breakline_space_only
    end

    def gun_graphic
      puts ' \\\__________'
      puts " |    ______-/   ---------------------------------------- =>"
      puts " / { }"
      puts "/__/"
    end

    def call
      breakline_space_only
      puts "Howdy, stranger!"
      breakline_title
      puts "The Kdnuggets Roundup is your source for the top articles in data science, as curated by KDnuggets.com."
      puts "Let's see what we can wrassle up..."
      KdnuggetsRoundup::DataWrassler.new.wrassle_top_stories
      main_menu
    end

    def main_menu
      input = nil
      articles = KdnuggetsRoundup::Article.all
      while input != 'quit'
        breakline_title
        puts "Pick yer poison, friend."
        breakline_space_only
        puts "Choose:"
        puts "'rank' to see the articles ranked by most popular and most shared,"
        puts "'article' to look more closely at a particular article, or"
        puts "'quit' to exit the program."
        gun_graphic
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when "rank"
          KdnuggetsRoundup::Article.display_rankings
        when "article"
          article_selection_menu(articles)
        when 'quit'
          break
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
      puts "Time to be hittin' th' ol' dusty trail..."
      puts "* * * * * * * * * * * * *"
      puts breakline_space_only
    end

    #helper method for article_submenu
    def calc_available_choices(articles)
      Array.new.tap do |avail_choices|
        (1..articles.count).each do |num|
          avail_choices << num.to_s
        end
      end
    end

    #submenu methods
    def article_selection_menu(articles)
      breakline_space_only
      avail_choices = calc_available_choices(articles)
      input = nil
      while input != 'menu'
        breakline_title
        KdnuggetsRoundup::Article.list(articles)
        breakline_space_only
        puts "Enter an article number and I'll lasso it up for ya."
        breakline_space_only
        puts "You can also choose:"
        puts "'rank' to see the articles ranked by most popular and most shared, or "
        puts "'menu' to return to the main menu."
        gun_graphic
        input = gets.chomp.downcase
        breakline_space_only
        if avail_choices.include?(input)
          puts "Here's that article you asked for:"
          breakline_space_only
          chosen_article = articles[input.to_i - 1]
          chosen_article.display_article
          article_selection_submenu(chosen_article, articles)
        elsif input == "rank"
          rank_submenu
        elsif input == "menu"
          break
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end

    def rank_submenu
      input = nil
      until input == 'menu'
        breakline_title
        KdnuggetsRoundup::Article.display_rankings
        puts "When you're ready to return to the article menu, type 'menu'."
        gun_graphic
        input = gets.chomp.downcase
      end
    end

    def article_selection_submenu(chosen_article, articles)
      input = nil
      while input != 'other'
        breakline_title
        puts "Like what you see?"
        breakline_space_only
        puts "Choose:"
        puts "'ex' to read an excerpt from the original article,"
        puts "'www' to navigate to the original article in your browser,"
        puts "'menu' to return to the article selection menu."
        gun_graphic
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when 'ex'
          chosen_article.read_excerpt
        when 'www'
          puts "Hold on to yer britches, we're headed to the World Wide Web!"
          system("open " + chosen_article.url)
        when 'menu'
          break #=> breaks out to submenu
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end


  end



end

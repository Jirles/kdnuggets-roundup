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
      puts ""
    end

    def breakline_end
      puts "* * * * * * * * *"
      puts ""
    end

    def call
      breakline_space_only
      puts "Howdy, stranger!"
      breakline_title
      puts "The Kdnuggets Roundup is your source for the top articles in data science as curated by KDnuggets.com."
      breakline_end
      KdnuggetsRoundup::DataWrassler.new.wrassle_top_stories
      menu
    end

    def menu
      input = nil
      while input != 'quit'
        puts "What can I lasso up for ya?"
        breakline_space_only
        puts "Choose:"
        puts "'list' to list all of the top articles for this past week,"
        puts "'filter' to filter articles by most popular or most shared,"
        puts "'article' to look more closely at a particular article, or"
        puts "'quit' to exit the program."
        puts ' \\\__________'
        puts " |    _______/   ---------------------------------------- =>"
        puts " / { }"
        puts "/__/"
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when "list"
          KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.all)
          breakline_title
        when "filter"
          puts "Pick your poison, friend: Most Popular or Most Shared?"
          filter_submenu
        when "article"
          article_submenu
        when 'quit'
          break
        else
          puts "Sorry, partner. Didn't catch that."
          breakline_title
        end
      end
      puts "Time to be hittin' th' ol' dusty trail..."
      breakline_end
    end

    #submenus methods

    def filter_submenu
      input = nil
      while input != 'menu'
        breakline_title
        puts "Enter 'popular' to see the most popular, 'shared' to see the most shared, or 'menu' to return to the main menu."
        input = gets.chomp.downcase
        if input == "popular"
          breakline_space_only
          KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.popular)
          breakline_space_only
        elsif input == "shared"
          breakline_space_only
          KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.shared)
          breakline_space_only
        elsif input == 'menu'
          breakline_end
          break
        else
          breakline_space_only
          puts "Sorry, partner. Didn't catch that."
          breakline_space_only
        end
      end
    end

    def calc_available_choices(articles)
      Array.new.tap do |avail_choices|
        (1..articles.count).each do |num|
          avail_choices << num.to_s
        end
      end
    end

    def article_submenu
      puts "Here's everything I could wrassle up. Now, which one catches yer eye?"
      breakline_space_only
      articles = KdnuggetsRoundup::Article.all
      avail_choices = calc_available_choices(articles)
      KdnuggetsRoundup::Article.list(articles)
      input = nil
      while input != 'menu'
        breakline_title
        puts "Choose an article number and I'll show ya more."
        puts "You can also type 'list' to see the articles listed again or 'menu' to return to the main menu."
        input = gets.chomp.downcase
        if avail_choices.include?(input) #=> to be fixed so it knows if a number in the correct range was chosen
          breakline_space_only
          puts "Here's that article you asked for:"
          breakline_space_only
          chosen_article = articles[input.to_i - 1]
          chosen_article.display_article #=> input converted to index
          article_view_submenu(chosen_article, articles)
          breakline_space_only
        elsif input == "list"
          breakline_space_only
          KdnuggetsRoundup::Article.list(articles)
        elsif input == 'menu'
          breakline_end
          break
        else
          breakline_space_only
          puts "Sorry, partner. Didn't catch that."
          breakline_space_only
        end
      end
    end

    def article_view_submenu(chosen_article, articles)
      input = nil
      while input != 'other'
        breakline_title
        puts "Like what you see?"
        breakline_space_only
        puts "Choose:"
        puts "'ex' to read a random excerpt of the original article,"
        puts "'www' to navigate to the original article in your browser,"
        puts "'again' to read the article summary again, or"
        puts "'other' to return to look at other articles."
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when 'ex'
          chosen_article.read_excerpt
        when 'www'
          puts "Hold on to yer britches, we're headed to the World Wide Web!"
        when 'again'
          chosen_article.display_article
        when 'other'
          breakline_end
          breakline_space_only
          KdnuggetsRoundup::Article.list(articles) #=> list articles before breaking out of this loop, as article_submenu does not automatically list once in the loop
          break
        else
          breakline_space_only
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end


  end



end

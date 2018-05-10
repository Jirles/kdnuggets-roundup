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
      while input != 'quit'
        breakline_title
        puts "What can I lasso up for ya?"
        breakline_space_only
        puts "Choose:"
        puts "'list' to list all of the top articles for this past week,"
        puts "'article' to look more closely at a particular article, or"
        puts "'quit' to exit the program."
        puts ' \\\__________'
        puts " |    ______-/   ---------------------------------------- =>"
        puts " / { }"
        puts "/__/"
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when "list"
          KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.all)
        when "article"
          article_submenu
        when 'quit'
          break
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
      puts "Time to be hittin' th' ol' dusty trail..."
      puts "                 _______  _____ "
      puts '                /       \/     \\'
      puts '               /                \\'
      puts '              /                  \\'
      puts '             /                    \\'
      puts '/           /---|-------|------|---\\            \\'
      puts '\_________ /-------|--------|-------\\___________/'
      puts ' \_____________________________________________/'
      puts breakline_space_only
    end

    #submenus methods
    def filter_submenu
      breakline_title
      puts "Pick your poison, friend: Most Popular or Most Shared?"
      puts "Enter 'popular' to see the most popular articles or 'shared' to see the most shared."
      input = gets.chomp.downcase
      breakline_space_only
      case input
      when "popular"
        KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.popular)
      when "shared"
        KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.shared)
      else
        puts "Sorry, partner. Didn't catch that."
      end
    end

    #helper method for article_submenu
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
        puts "You can also choose:"
        puts "'list' to see all the articles listed again,"
        puts "'filter' to filter articles by most popular or most shared, or"
        puts "'menu' to return to the main menu."
        input = gets.chomp.downcase
        breakline_space_only
        if avail_choices.include?(input)
          puts "Here's that article you asked for:"
          breakline_space_only
          chosen_article = articles[input.to_i - 1]
          chosen_article.display_article
          article_sub_submenu(chosen_article, articles)
        elsif input == "list"
          KdnuggetsRoundup::Article.list(articles)
        elsif input == "filter"
          filter_submenu
        elsif input == "menu"
          break
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end

    def article_sub_submenu(chosen_article, articles)
      input = nil
      while input != 'other'
        breakline_title
        puts "Like what you see?"
        breakline_space_only
        puts "Choose:"
        puts "'ex' to read an excerpt from the original article,"
        puts "'www' to navigate to the original article in your browser,"
        puts "'again' to see the article summary again, or"
        puts "'other' to look at other articles."
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when 'ex'
          chosen_article.read_excerpt
        when 'www'
          puts "Hold on to yer britches, we're headed to the World Wide Web!"
          system("open " + chosen_article.url)
        when 'again'
          chosen_article.display_article
        when 'other'
          breakline_space_only
          KdnuggetsRoundup::Article.list(articles) #=> list articles before breaking out of this loop, as article_submenu does not automatically list once in the loop
          break #=> breaks out to article_submenu
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end


  end



end

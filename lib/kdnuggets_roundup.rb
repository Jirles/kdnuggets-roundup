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
      articles = KdnuggetsRoundup::Article.all
      while input != 'quit'
        breakline_title
        puts "What can I lasso up for ya?"
        breakline_space_only
        puts "Choose:"
        puts "'rank' to see the articles ranked by most popular and most shared,"
        puts "'article' to look more closely at a particular article, or"
        puts "'quit' to exit the program."
        puts ' \\\__________'
        puts " |    ______-/   ---------------------------------------- =>"
        puts " / { }"
        puts "/__/"
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when "rank"
          puts "Most Popular"
          KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.popular)
          breakline_space_only
          puts "Most Shared"
          KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.shared)
          breakline_space_only
        when "article"
          article_submenu(articles)
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

    #helper method for article_submenu
    def calc_available_choices(articles)
      Array.new.tap do |avail_choices|
        (1..articles.count).each do |num|
          avail_choices << num.to_s
        end
      end
    end

    #submenu methods
    def article_submenu(articles)
      breakline_space_only
      avail_choices = calc_available_choices(articles)
      input = nil
      while input != 'menu'
        breakline_title
        KdnuggetsRoundup::Article.list(articles)
        breakline_space_only
        puts "Pick your poison, friend. Enter an article number and I'll show ya more."
        breakline_space_only
        puts "You can also choose:"
        puts "'rank' to see the articles ranked by most popular and most shared, or "
        puts "'menu' to return to the main menu."
        input = gets.chomp.downcase
        breakline_space_only
        if avail_choices.include?(input)
          puts "Here's that article you asked for:"
          breakline_space_only
          chosen_article = articles[input.to_i - 1]
          chosen_article.display_article
          article_sub_submenu(chosen_article, articles)
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
        puts "Most Popular"
        KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.popular)
        breakline_space_only
        puts "Most Shared"
        KdnuggetsRoundup::Article.list(KdnuggetsRoundup::Article.shared)
        breakline_space_only
        puts "When you're ready to return to the article menu, type 'menu'."
        input = gets.chomp.downcase
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
        puts "'other' to look at other articles."
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when 'ex'
          chosen_article.read_excerpt
        when 'www'
          puts "Hold on to yer britches, we're headed to the World Wide Web!"
          system("open " + chosen_article.url)
        when 'other'
          break #=> breaks out to article_submenu
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end


  end



end

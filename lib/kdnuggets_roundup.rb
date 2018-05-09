require "kdnuggets_roundup/version"
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
      puts "Howdy!"
      breakline_title
      puts "The Kdnuggets Roundup is your source for the top articles in data science as curated by KDnuggets.com."
      puts "So, what brings ya 'round these parts, stranger?"
      breakline_end
      #scraper call
      menu
    end


    def filter_submenu
      input = nil
      article1 = KdnuggetsRoundup::Article.new("There's a snake in my boot! Python tips ;)")
      article2 = KdnuggetsRoundup::Article.new("What the hell is a tensor?")
      article3 = KdnuggetsRoundup::Article.new("Big Data? I hardly knew her!")
      article1.add_to_popular
      article2.add_to_popular
      article3.add_to_shared
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
      article1 = KdnuggetsRoundup::Article.new("There's a snake in my boot! and other Python tips")
      article2 = KdnuggetsRoundup::Article.new("What the hell is a tensor?")
      article3 = KdnuggetsRoundup::Article.new("Big Data? I hardly knew her!")
      article1.author = "Annie Oakley"
      article1.tags = ['Data science', 'Python', 'Gun slingin\'']
      article1.summary = "Learn some nifty tips on using Python, a popular and powerful programming language"
       # => create articles so they populate with #list and #display_article
      puts "Here's everything I could 'rassle up. Now, which one catches yer eye?"
      breakline_space_only
      articles = KdnuggetsRoundup::Article.all
      avail_choices = calc_available_choices(articles)
      KdnuggetsRoundup::Article.list(articles)
      input = nil
      while input != 'menu'
        breakline_title
        puts "Choose a number and I'll show ya more."
        puts "Ya can also type 'list' to see the articles listed again or 'menu' to return to the main menu."
        input = gets.chomp.downcase
        if avail_choices.include?(input) #=> to be fixed so it knows if a number in the correct range was chosen
          breakline_space_only
          puts "Here's that article you asked for: "
          breakline_space_only
          chosen_article = articles[input.to_i - 1]
          chosen_article.display_article #=> input converted to index
          article_view_submenu(chosen_article)

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

    def article_view_submenu(chosen_article)
      input = nil
      while input != 'other'
        breakline_title
        puts "Like what you see?"
        breakline_space_only
        puts "Choose:"
        puts "'ex' to read a excerpt of the original article,"
        puts "'www' to navigate to the original article in your browser,"
        puts "'again' to read the article summary again, or"
        puts "'other' to return to look at other articles."
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when 'ex'
          chosen_article.read_excerpt
        when 'www'
          puts "Hold on to your britches, we headed to the World Wide Web!"
        when 'again'
          chosen_article.display_article
        when 'other'
          breakline_end
          break
        else
          breakline_space_only
          puts "Sorry, partner. Didn't catch that."
        end
      end
    end

    def display_main_menu
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
    end

    def menu
      input = nil
      while input != 'quit'
        display_main_menu
        input = gets.chomp.downcase
        breakline_space_only
        case input
        when "list"
          article1 = KdnuggetsRoundup::Article.new("There's a snake in my boot! and other Python tips.")
          article2 = KdnuggetsRoundup::Article.new("What the hell is a tensor?")
          article3 = KdnuggetsRoundup::Article.new("Big Data? I hardly knew her!")
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

  end



end

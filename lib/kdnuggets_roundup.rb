require "kdnuggets_roundup/version"
require "article"

module KdnuggetsRoundup

  class RoundupCLI
    def call
      puts "Howdy, partner!"
      puts "The Kdnuggets Roundup is your source for the top articles in data science."
      puts "Let's see what we can lasso up this week!"
      puts ""
      #scraper call
      menu
    end

    def display_main_menu
      puts "So, what brings you 'round these parts, stranger? Please enter:"
      puts "'l' to list all of the top articles for this past week"
      puts "'f' to filter articles by most popular or most shared,"
      puts "'a' to look more closely at a particular article, or"
      puts "'q' to quit."
      puts ' \\\___________'
      puts " |    _______   ----------------[BANG]------------------- =>"
      puts " / { }"
      puts "/__/"
    end

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

    def popular_shared_submenu
      puts "Enter 'popular' to see the most popular, 'shared' to see the most shared, or 'menu' to return to the main menu."
      input = gets.chomp.downcase
      case input
      when "popular"
        breakline_space_only
        KdnuggetsRoundup::Article.list_popular
      when "shared"
        breakline_space_only
        KdnuggetsRoundup::Article.list_shared
      when 'menu'
        breakline_end
        break
      else
        breakline_space_only
        puts "Sorry, partner. Didn't catch that."
      end
    end

    def menu
      input = nil
      while input != 'q'
        display_main_menu
        input = gets.chomp.downcase
        case input
        when "l"
          article1 = KdnuggetsRoundup::Article.new("There's a snake in my boot! Python tips ;)")
          article2 = KdnuggetsRoundup::Article.new("What the hell is a tensor?")
          article3 = KdnuggetsRoundup::Article.new("Big Data? I hardly knew her!")
          puts ". . ."
          KdnuggetsRoundup::Article.list_all
        when "f"
          puts "Pick your poison, friend: Most Popular or Most Shared?"
          breakline_title
          popular_shared_submenu
        when "a"
          puts "this will lead to a submenu letting you choose an article"
        when 'q'
          break
        else
          puts "Sorry, partner. Didn't catch that."
        end
      end
      puts ""
    end

  end



end

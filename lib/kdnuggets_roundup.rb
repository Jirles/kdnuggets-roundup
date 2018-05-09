require "kdnuggets_roundup/version"
require "article"

module KdnuggetsRoundup

  class RoundupCLI
    def call
      puts "Howdy, partner!"
      puts "The Kdnuggets Roundup is your source for the top articles in data science."
      puts "Let's see what's hot this week!"
      menu
    end

    def display_main_menu
      puts "What brings you 'round these parts, stranger? Please enter:"
      puts "'l' to list all of the top articles for this past week"
      puts "'f' to filter articles by most popular or most shared,"
      puts "'a' to look more closely at a particular article, or"
      puts "'q' to quit."
    end

    def popular_shared_submenu
      "this will be something"
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

          KdnuggetsRoundup::Article.list_all
        when "f"
          puts "Pick your poison, friend: Most Popular or Most Shared?"
          popular_shared_submenu
        when "a"
          puts "this will lead to a submenu letting you choose an article"
        when 'q'
          break
        else
          puts "Invalid request. Please try again."
        end
      end
    end

  end



end

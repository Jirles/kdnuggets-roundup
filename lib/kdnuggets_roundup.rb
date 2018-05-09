require "kdnuggets_roundup/version"

module KdnuggetsRoundup

  class RoundupCLI
    def call
      puts "Howdy, partner!"
      puts "The Kdnuggets Roundup is your source for the top articles in data science."
      puts "Let's see what's hot this week!"
      menu
    end

    def display_main_menu
      puts "What are you looking for? Please enter:"
      puts "'l' to list all of the top articles for this past week"
      puts "'f' to filter articles by most popular or most shared,"
      puts "'a' to look more closely at a particular article, or"
      puts "'q' to quit."
    end

    def menu
      input = nil
      while input != 'q'
        display_main_menu
        input = gets.chomp.downcase
        case input
        when "l"
          puts "list all"
        when "f"
          puts "leads to a submenu where user can toggle between most popular or most shared"
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

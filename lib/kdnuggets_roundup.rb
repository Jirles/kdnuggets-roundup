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
      puts "'p' to see the most popular articles,"
      puts "'s' to see the most shared articles, or"
      puts "'q' to quit."
    end

    def menu
      display_main_menu
    end

  end



end

require "kdnuggets_roundup/version"
require "datawrassler"
require "article"

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

    #article / collection display methods

    def list(collection)
      collection.each_with_index do |article, i|
        puts "#{i + 1}. #{article.title}"
      end
    end

    def display_article(article)
      puts <<-DOC
      #{article.title}
      By: #{article.author}
      Tags: #{article.tags.dup.join(', ')}

      Summary
      -------
      #{article.summary}
      DOC
    end

    def display_rankings
      puts "Most Popular"
      list(KdnuggetsRoundup::Article.popular)
      puts ""
      puts "Most Shared"
      list(KdnuggetsRoundup::Article.shared)
      puts ""
    end

    def read_excerpt(article)
      article.excerpt.each do |paragraph|
        puts paragraph
      end
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
          display_rankings
        when "article"
          article_selection_menu
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

    #submenu methods
    def article_selection_menu
      breakline_space_only
      avail_choices = (1..KdnuggetsRoundup::Article.all.count).collect{ |num| num.to_s }
      input = nil
      while input != 'menu'
        breakline_title
        list(KdnuggetsRoundup::Article.all)
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
          chosen_article = KdnuggetsRoundup::Article.all[input.to_i - 1]
          display_article(chosen_article)
          article_selection_submenu(chosen_article)
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
        display_rankings
        puts "When you're ready to return to the article menu, type 'menu'."
        gun_graphic
        input = gets.chomp.downcase
      end
    end

    def article_selection_submenu(chosen_article)
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
          read_excerpt(chosen_article)
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

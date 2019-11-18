require 'googlebooks'

class BookListCli::CLI

    @@list
    
    def call
        welcome
        @@list = BookListCli::List.new
        menu_options
        goodbye
    end

    def menu_options
        loop do
            puts "1 - Search"
            puts "2 - View Reading List"
            puts "'exit' or 'quit' when finished"
            border
            input = gets.strip.downcase
            break if input == "quit" || input == "exit"
            case input
            when "1"
              search
            when "2"
              @@list.display_reading_list
            else
              puts "Invalid input: #{input}"
            end
        end
    end

    def save_books(books)
        if books.total_items > 0
        books.each do |book|
            new_book = BookListCli::Book.new
            new_book.title = book.title
            new_book.authors = book.authors || "Unknown Author(s)"
            new_book.publisher = book.publisher || "Unknown Publisher"
            new_book.save
        end
        else
            puts "No books were returned, check your spelling or try another query."
            false
        end
    end

    def search
        puts "Please enter your search query:"  
        input = gets.strip
        books = GoogleBooks.search(input, {:count => 5})
        if save_books(books)
            puts "Your search has returned the following results:"
            @@list.display_books(books)
            @@list.reading_list_options
        end
    end

    def welcome
        border
        puts "Welcome to BookListCLI! Query the GoogleBooks API and construct your own reading list."
        puts "Enter your selection below."
        border
    end

    def goodbye
        puts "See you tomorrow for more books!"
    end

    def border
        puts " -- -- -- -- -- "
    end
end
# CLI Controller
require 'googlebooks'
class BookListCli::CLI
    @@reading_list = []
    @@searches = 0

    def call
        menu_options
        goodbye
    end

    def save(book)
        @@reading_list.push(book)
    end

    def display_books(books)
        book_index = 0
        books.each do |book|
            puts "#{book_index += 1}. #{book.title} by #{book.authors}."
            puts "Publisher: #{book.publisher}"
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
        puts "Enter your search query"  
        input = gets.strip
        books = GoogleBooks.search(input, {:count => 5})
        if save_books(books)
            display_books(books)
            save_to_reading_list?
        end
    end

    def display_reading_list
        if @@reading_list.size > 0
            puts "-- Your Reading List --"
            display_books(@@reading_list)
        else
            puts "Nothing on your reading list yet."
        end
    end

    def save_to_reading_list?
        puts "Would you like to save a book to your reading list? Enter the number above, or enter any other key to return to the menu."
        choice = gets.strip.downcase
            case choice
            when /[1-5]/
                base_index = @@searches * 5
                chosen_book = BookListCli::Book.all[(choice.to_i - 1) + base_index]
                save(chosen_book)
                puts "Book saved: #{chosen_book.title}. You now have #{@@reading_list.size} items on your reading list."
                @@searches += 1
            when /[^1-5]/
                @@searches += 1
                return
            end
    end

    def menu_options
        loop do
            puts "1 - Search, 2 - Reading List, or 'exit'"
            input = gets.strip.downcase
            break if input == "quit" || input == "exit"
            case input
            when "1"
              search
            when "2"
              display_reading_list
            else
              puts "invalid_input: #{input}"
            end
          end
    end

    def goodbye
        puts "See you tomorrow for more books"
    end 
end
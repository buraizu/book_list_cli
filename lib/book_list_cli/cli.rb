class BookListCli::CLI
    @@reading_list = []
    @@searches = 0

    def call
        welcome
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
              books = BookListCli::Search.new.query
              display_books(books)
              save_to_reading_list?
            when "2"
              display_reading_list
            else
              puts "Invalid input: #{input}"
            end
        end
    end

    def display_books(books)
        book_index = 0
        border
        books.each do |book|
            puts "#{book_index += 1}. #{book.title} by #{book.authors}."
            puts "Publisher: #{book.publisher}"
            border
        end 
    end

    def display_reading_list
        if @@reading_list.size > 0
            puts "-- Your Reading List --"
            display_books(@@reading_list)
        else
            puts " -- There is currently nothing on your reading list. -- "
        end
    end

    def save(book)
        @@reading_list.push(book)
    end

    def save_to_reading_list?
        puts "To save a book to your reading list, simply enter its number." 
        puts "Example: Enter '25' to save books numbered 2 and 5."
        puts "Enter any other key to return to the menu."
        border
        choices = gets.strip.split('').sort
        base_index = @@searches * 5
        @@searches += 1
        choices.each.with_index do |c, i|
            if /[1-5]/.match(c) && choices[i + 1] != c
                chosen_book = BookListCli::Book.all[(c.to_i - 1) + base_index]
                save(chosen_book)
                puts " -- Book saved: #{chosen_book.title} by #{chosen_book.authors}"
            end
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
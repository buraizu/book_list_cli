class BookListCli::List

    @@books = []
    @@searches = 0

    def save_to_reading_list(book)
        @@books << book
    end

    def reading_list_options
        puts "To save a book to your reading list, simply enter its number." 
        puts "Example: Enter '25' to save books numbered 2 and 5."
        puts "Enter any other key to return to the menu."
        puts " -- -- -- -- -- "
        choices = gets.strip.split('').sort
        base_index = @@searches * 5
        @@searches += 1
        choices.each.with_index do |c, i|
            if /[1-5]/.match(c) && choices[i + 1] != c
                chosen_book = BookListCli::Book.all[(c.to_i - 1) + base_index]
                save_to_reading_list(chosen_book)
                puts " -- Book saved: #{chosen_book.title} by #{chosen_book.authors}"
            end
        end
    end

    def list_books(books)
        book_index = 0
        puts " -- -- -- -- -- "
        books.each do |book|
            puts "#{book_index += 1}. #{book.title} by #{book.authors}."
            puts "Publisher: #{book.publisher}"
            puts " -- -- -- -- -- "
        end 
    end

    def display_reading_list
        if @@books.size > 0
            puts "-- Your Reading List --"
            list_books(@@books)
        else
            puts " -- There is currently nothing on your reading list. -- "
        end
    end
  
end
# CLI Controller
require 'googlebooks'
class BookListCli::CLI
    @@reading_list = []

    def call
        menu
        goodbye
    end

    def save(book)
        @@reading_list.push(book)
        puts "Reading List is now: #{@@reading_list}"
    end

    def search
        puts "Enter your search query"
        index = 0    
        input = gets.strip
        books = GoogleBooks.search(input, {:count => 5})
        books.each do |book|
            puts "#{index += 1}"
            puts "Author: #{book.authors}"
            puts "Title: #{book.title}"
            puts "Publisher: #{book.publisher}"
        end

        puts "Would you like to save a book to your reading list? Enter the number above"
            input2 = gets.strip
            save(input2)
    end

    def reading_list
        reading_list_index = 0
        if @@reading_list.size > 0
            puts "Here is your reading list"
            @@reading_list.each do |book|
                puts "#{reading_list_index += 1}"
                puts "Author: #{book.authors}"
                puts "Title: #{book.title}"
                puts "Publisher: #{book.publisher}" 
            end
        else 
            puts "You currently have no books saved to your reading list."
        end
    end

    def menu
        input = nil
        puts "Enter 1 to search for books, or 2 to see your reading list, or 'exit'"
        input = gets.strip
        while input != "exit"
           case input
           when "1"
            search
           when "2"
            reading_list
           end
        end

        goodbye
    end

    def goodbye
        puts "See you tomorrow for more books"
    end 
end
# CLI Controller
require 'googlebooks'

class BookListCli::CLI
    def call
        menu
        goodbye
    end

    def menu
        input = nil
        while input != "exit"
            puts "Enter your search query"
            input = gets.strip
            books = GoogleBooks.search(input)
            first_book = books.first
            puts first_book.authors
            puts first_book.title
            puts first_book.publisher
        end
    end

    def goodbye
        puts "See you tomorrow for more books"
    end 
end
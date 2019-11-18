require 'googlebooks'

class BookListCli::Search

    def query
        puts "Please enter your search query:"  
        input = gets.strip
        books = GoogleBooks.search(input, {:count => 5})
        if save_books(books)
            puts "Your search has returned the following results:"
            books
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

end
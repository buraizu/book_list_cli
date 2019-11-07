class BookListCli::Book

    attr_accessor :title, :authors, :publisher, :index
  
    @@all = []
  
    def self.all
      @@all
    end
  
    def save
      @@all << self
    end
  
  end
class Brewery < ApplicationRecord
    has_many :beers

    def print_report
        puts self.name
        puts "established at year #{self.year}"
        puts "number of beers #{self.beers.count}"
    end

    def restart
        self.year = 2018
        puts "changed year to #{self.year}"
    end
end

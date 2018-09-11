class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def print_report
        puts self.name
        puts "established at year #{self.year}"
        puts "number of beers #{self.beers.count}"
    end

    def restart
        self.year = 2018
        puts "changed year to #{self.year}"
    end

    def average_rating
        sum = self.ratings.inject(0.0) { |sum, rating| sum + rating.score }
        average = sum / self.ratings.length
        return average.round(2)
    end
end

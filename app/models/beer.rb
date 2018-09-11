class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        sum = self.ratings.inject(0.0) { |sum, rating| sum + rating.score }
        average = sum / self.ratings.length
        return average.round(2)
    end
end

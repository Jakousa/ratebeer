class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        k = 0.0
        self.ratings.each do |rating|
            k += rating.score
        end
        return k / self.ratings.length
    end
end

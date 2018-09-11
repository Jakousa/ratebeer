module RatingAverage
    extend ActiveSupport::Concern
   
    def average_rating
        sum = self.ratings.inject(0.0) { |sum, rating| sum + rating.score }
        average = sum / self.ratings.length
        return average.round(2)
    end
end
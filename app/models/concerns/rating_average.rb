module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    sum = ratings.inject(0.0) { |acc, cur| acc + cur.score }
    average = sum / ratings.length
    average.round(2)
  end
end

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.count == 0

    sum = ratings.inject(0.0) { |acc, cur| acc + cur.score }
    average = sum / ratings.length
    average.round(2)
  end
end

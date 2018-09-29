module RatingTop
  extend ActiveSupport::Concern

  def top(number)
    sorted_by_rating_in_desc_order = all.sort_by{ |b| - b.average_rating }
    sorted_by_rating_in_desc_order[0, number]
  end
end

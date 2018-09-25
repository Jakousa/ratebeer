class Style < ApplicationRecord
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def self.top(number)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order[0, number]
  end

  def to_s
    name
  end
end

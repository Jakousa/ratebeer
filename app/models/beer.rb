class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }

  def self.top(number)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order[0, number]
  end

  def to_s
    "#{name}, #{Brewery.find(brewery_id).name}"
  end
end

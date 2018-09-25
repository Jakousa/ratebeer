class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validate :year_cannot_be_greater_than_now

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def year_cannot_be_greater_than_now
    errors.add(:year, "can't be in the future") if year > Date.today.year
  end

  validates :name, length: { minimum: 1 }

  def self.top(number)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order[0, number]
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    year = 2018
    puts "changed year to #{year}"
  end
end

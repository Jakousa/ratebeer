class Brewery < ApplicationRecord
  include RatingAverage
  extend RatingTop

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validate :year_cannot_be_greater_than_now

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def year_cannot_be_greater_than_now
    errors.add(:year, "can't be in the future") if year > Date.today.year
  end

  validates :name, length: { minimum: 1 }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    year = 2018
    puts "changed year to #{year}"
  end

  def to_s
    name
  end
end

class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   less_than_or_equal_to: 2019,
                                   only_integer: true }

  validates :name, uniqueness: true,
                   length: { minimum: 1 }

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

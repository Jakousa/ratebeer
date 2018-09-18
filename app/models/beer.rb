class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, uniqueness: true,
                   length: { minimum: 1 }

  def to_s
    "#{name}, #{Brewery.find(brewery_id).name}"
  end
end

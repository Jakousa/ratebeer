class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates_format_of :password, with: /.*[A-Z].*\d.*|.*\d.*[A-Z].*/

  validates :password, length: { minimum: 4 }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.each_with_object({}){ |rating, acc|
      acc[rating.beer.style] = 0 if !acc[rating.beer.style]
      acc[rating.beer.style] = acc[rating.beer.style] + rating.score
    }.max_by{ |_k, v| v }[0]
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.each_with_object({}){ |rating, acc|
      acc[rating.beer.brewery] = 0 if !acc[rating.beer.brewery]
      acc[rating.beer.brewery] = acc[rating.beer.brewery] + rating.score
    }.max_by{ |_k, v| v }[0]
  end
end

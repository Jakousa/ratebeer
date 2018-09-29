class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, -> { where confirmed: true }, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :applications, -> { where confirmed: [false, nil] }, class_name: "Membership", dependent: :destroy
  has_many :clubs_applied_to, through: :applications, source: :beer_club

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates_format_of :password, with: /.*[A-Z].*\d.*|.*\d.*[A-Z].*/

  validates :password, length: { minimum: 4 }

  def self.top(number)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -b.ratings.count }
    sorted_by_rating_in_desc_order[0, number]
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite(groupped_by)
    return nil if ratings.empty?

    ratings.each_with_object({}){ |rating, acc|
      acc[rating.beer.send(groupped_by)] = 0 if !acc[rating.beer.send(groupped_by)]
      acc[rating.beer.send(groupped_by)] = acc[rating.beer.send(groupped_by)] + rating.score
    }.max_by{ |_k, v| v }[0]
  end

  def method_missing(method_name, *args, &block)
    return super if method_name !~ /^favorite_/

    category = method_name[9..-1].to_sym
    favorite category
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('favorite_') || super
  end

  def to_s
    username
  end
end

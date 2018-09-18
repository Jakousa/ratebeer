class Rating < ApplicationRecord
  belongs_to :beer

  def to_s
    "#{Beer.find(beer_id).name} #{score}"
  end
end

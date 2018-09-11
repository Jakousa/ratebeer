class Rating < ApplicationRecord
    belongs_to :beer

    def to_s
        puts 'Lol'
        return "#{Beer.find(self.beer_id).name} #{self.score}"
    end
end

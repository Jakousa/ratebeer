class AddStyleIdToBeers < ActiveRecord::Migration[5.2]
  def up
    add_column :beers, :style_id, :integer
    Beer.all().each { |beer| 
      beer.style_id = Style.find_by(name: beer.style).id rescue nil
      beer.save()
    }
  end

  def down
    remove_column :beers, :style_id
  end
end

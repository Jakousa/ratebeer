class AddInitialStyles < ActiveRecord::Migration[5.2]
  def up
    ["Weizen", "Lager", "Pale Ale", "IPA", "Porter"].each { |style| 
      Style.create(name: style, description: "Not yet described")
    }
  end
 
  def down
    Style.delete_all
  end
end

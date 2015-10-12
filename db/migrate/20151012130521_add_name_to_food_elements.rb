class AddNameToFoodElements < ActiveRecord::Migration
  def change
    add_column :food_elements, :name, :string
  end
end

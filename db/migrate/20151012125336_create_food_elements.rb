class CreateFoodElements < ActiveRecord::Migration
  def change
    create_table :food_elements do |t|
      t.string :image_path
      t.text :nutrition_info
      t.text :nutrition_value
      t.text :edible_effect
      t.text :applicable_people

      t.timestamps null: false
    end
  end
end

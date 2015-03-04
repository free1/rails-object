class AddWeightToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :weight, :integer, default: 0
  end
end

class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :number
      t.integer :state
      t.decimal :trans_amount, precision: 8, scale: 2, default: 0.0

      t.timestamps null: false
    end
  end
end

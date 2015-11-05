class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone_no
      t.string :verify_code

      t.timestamps null: false
    end
  end
end

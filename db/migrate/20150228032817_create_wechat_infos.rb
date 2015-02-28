class CreateWechatInfos < ActiveRecord::Migration
  def change
    create_table :wechat_infos do |t|
      t.string :public_name
      t.string :number
      t.string :qr_code
      t.string :keyword

      t.timestamps null: false
    end
  end
end

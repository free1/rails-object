class AddPeriodsToArticleLists < ActiveRecord::Migration
  def change
  	add_column :article_lists, :periods, :string
  end
end

class AddSourceSiteToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :source_site, :string
  end
end

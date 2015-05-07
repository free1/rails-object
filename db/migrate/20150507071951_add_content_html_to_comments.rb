class AddContentHtmlToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :content_html, :text
  end
end

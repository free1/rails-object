class AddVerifyEmailToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :verify_token, :string
  	add_column :users, :is_verify_email, :boolean, default: false
  end
end

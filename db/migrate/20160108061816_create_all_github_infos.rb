class CreateAllGithubInfos < ActiveRecord::Migration
  def change
    create_table :all_github_infos do |t|
      t.string :organization_name
      t.text :organization_member

      t.timestamps null: false
    end
  end
end

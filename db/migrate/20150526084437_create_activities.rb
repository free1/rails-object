# Migration responsible for creating a table with activities
class CreateActivities < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :activities do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, :polymorphic => true

      t.timestamps
    end

    add_index :activities, [:trackable_id, :trackable_type], length: {trackable_id: 4, trackable_type: 100}
    add_index :activities, [:owner_id, :owner_type], length: {owner_id: 4, owner_type: 100}
    add_index :activities, [:recipient_id, :recipient_type], length: {recipient_id: 4, recipient_type: 100}
  end
  # Drop table
  def self.down
    drop_table :activities
  end
end

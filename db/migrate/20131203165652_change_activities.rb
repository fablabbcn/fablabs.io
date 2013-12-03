class ChangeActivities < ActiveRecord::Migration
  def change
    remove_index :activities, :user_id
    rename_column :activities, :user_id, :creator_id
    add_index :activities, :creator_id
    add_column :activities, :actor_id, :integer
    add_index :activities, :actor_id
  end
end

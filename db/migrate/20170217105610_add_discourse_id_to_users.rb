class AddDiscourseIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :discourse_id, :string
  end
end

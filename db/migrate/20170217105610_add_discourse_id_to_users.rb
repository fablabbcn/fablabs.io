class AddDiscourseIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :discourse_id, :string
  end
end

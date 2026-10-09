class AddDiscourseIdToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :discourse_id, :string
  end
end

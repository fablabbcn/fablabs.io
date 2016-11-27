class AddDiscourseIdToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :discourse_id, :string
  end
end

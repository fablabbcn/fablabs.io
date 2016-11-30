class AddDiscourseToThings < ActiveRecord::Migration
  def change
    add_column :things, :discourse_id, :string
    add_column :things, :discourse_errors, :text
  end
end

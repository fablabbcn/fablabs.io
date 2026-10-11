class AddDiscourseToThings < ActiveRecord::Migration[4.2]
  def change
    add_column :things, :discourse_id, :string
    add_column :things, :discourse_errors, :text
  end
end

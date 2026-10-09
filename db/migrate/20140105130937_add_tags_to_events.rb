class AddTagsToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :tags, :integer
    add_index :events, :tags
  end
end

class AddTagsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :tags, :integer
    add_index :events, :tags
  end
end

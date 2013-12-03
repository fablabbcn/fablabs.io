class ChangeToolsToThings < ActiveRecord::Migration
  def change
    rename_table :tools, :things
    add_column :things, :type, :string
    add_column :things, :inventory_item, :boolean, default: false
    add_index :things, [:id, :type, :inventory_item]
    Thing.update_all("type = 'Machine'")
  end
end

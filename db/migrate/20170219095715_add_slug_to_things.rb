class AddSlugToThings < ActiveRecord::Migration
  def change
    add_column :things, :slug, :string
    add_index :things, :slug, unique: true
  end
end

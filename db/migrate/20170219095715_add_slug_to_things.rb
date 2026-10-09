class AddSlugToThings < ActiveRecord::Migration[4.2]
  def change
    add_column :things, :slug, :string
    add_index :things, :slug, unique: true
  end
end

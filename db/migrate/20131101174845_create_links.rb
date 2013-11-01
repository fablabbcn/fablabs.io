class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :lab
      t.integer :ordinal
      t.string :url
      t.string :description

      t.timestamps
    end
    add_index :links, [:lab_id, :ordinal]
  end
end

class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :linkable, polymorphic: true
      t.integer :ordinal
      t.string :url
      t.string :description
      t.string :workflow_state
      t.references :creator, index: true
      t.timestamps
    end
    add_index :links, [:linkable_id, :linkable_type, :ordinal]
  end
end

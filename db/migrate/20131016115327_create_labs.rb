class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :workflow_state
      t.string :name
      t.string :slug
      t.text :description
      t.references :creator
      t.timestamps
    end
  end
end

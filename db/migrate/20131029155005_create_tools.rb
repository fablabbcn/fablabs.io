class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|

      t.string :name
      t.references :brand, index: true
      t.text :description
      t.string :workflow_state
      t.string :ancestry

      t.timestamps
    end
  end
end

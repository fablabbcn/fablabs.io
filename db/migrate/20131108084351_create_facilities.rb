class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.references :lab
      t.references :tool
      t.text :notes

      t.timestamps
    end
    add_index :facilities, [:lab_id, :tool_id], unique: true
  end
end

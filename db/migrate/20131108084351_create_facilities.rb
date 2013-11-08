class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.references :lab
      t.references :thing, polymorphic: true
      t.text :notes

      t.timestamps
    end
    add_index :facilities, [:lab_id, :thing_type, :thing_id], unique: true
  end
end

class RemoveThingTypeFromFacilities < ActiveRecord::Migration
  def change
    remove_index :facilities, [:lab_id, :thing_type, :thing_id]
    remove_column :facilities, :thing_type
    add_index :facilities, [:lab_id, :thing_id], unique: true
  end
end

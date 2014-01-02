class CreateAcademics < ActiveRecord::Migration
  def change
    create_table :academics do |t|
      t.belongs_to :user
      t.belongs_to :lab
      t.integer :started_in
      t.string :type
      t.belongs_to :approver

      t.timestamps
    end
    add_index :academics, [:user_id, :lab_id], unique: true
    add_index :academics, :approver_id
  end
end

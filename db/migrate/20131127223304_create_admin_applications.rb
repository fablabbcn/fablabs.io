class CreateAdminApplications < ActiveRecord::Migration
  def change
    create_table :admin_applications do |t|
      t.references :applicant
      t.references :lab
      t.text :notes
      t.string :workflow_state
      t.timestamps
    end
    add_index :admin_applications, [:applicant_id, :lab_id]
  end
end

class CreateRoleApplications < ActiveRecord::Migration
  def change
    create_table :role_applications do |t|
      t.references :user
      t.references :lab
      t.string :workflow_state
      t.text :description

      t.timestamps
    end
    add_index(:role_applications, [ :user_id, :lab_id ])

  end
end

class CreateLabOrganizations < ActiveRecord::Migration
  def change
    create_table :lab_organizations do |t|
      t.references :lab, index: true
      t.references :organization, index: true
      t.string :workflow_state

      t.timestamps
    end
  end
end

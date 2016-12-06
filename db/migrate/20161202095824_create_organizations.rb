class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.integer :creator_id
      t.string :slug
      t.string :kind
      t.string :blurb
      t.string :avatar_src
      t.string :header_image_src
      t.string :phone
      t.string :email
      t.text   :application_notes
      t.string :discourse_id
      t.string :discourse_errors
      t.string :workflow_state

      t.timestamps
    end
  end
end

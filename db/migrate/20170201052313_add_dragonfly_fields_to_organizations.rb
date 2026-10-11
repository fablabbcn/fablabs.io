class AddDragonflyFieldsToOrganizations < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :avatar_uid, :string
    add_column :organizations, :avatar_name, :string
    add_column :organizations, :header_uid, :string
    add_column :organizations, :header_name, :string
  end
end

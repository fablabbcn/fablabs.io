class AddHeaderDragonflyToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :header_uid, :string
    add_column :labs, :header_name, :string
  end
end

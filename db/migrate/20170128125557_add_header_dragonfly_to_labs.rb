class AddHeaderDragonflyToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :header_uid, :string
    add_column :labs, :header_name, :string
  end
end

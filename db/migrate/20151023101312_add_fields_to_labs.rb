class AddFieldsToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :network, :boolean, :default => false
    add_column :labs, :programs, :boolean, :default => false
    add_column :labs, :tools, :boolean, :default => false

  end
end

class AddOrderToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :order, :integer
    add_index :organizations, :order
  end
end

class AddOrderToOrganizations < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :order, :integer
    add_index :organizations, :order
  end
end

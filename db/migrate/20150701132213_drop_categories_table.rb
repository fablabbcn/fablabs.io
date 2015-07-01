class DropCategoriesTable < ActiveRecord::Migration
  def up
    drop_table :categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

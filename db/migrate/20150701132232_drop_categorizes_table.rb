class DropCategorizesTable < ActiveRecord::Migration
  def up
    drop_table :categorizes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

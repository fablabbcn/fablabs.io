class DropCategorizesTable < ActiveRecord::Migration[4.2]
  def up
    drop_table :categorizes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

class AddMetaToAcademics < ActiveRecord::Migration[4.2]
  def change
    add_column :academics, :meta, :hstore
  end
end

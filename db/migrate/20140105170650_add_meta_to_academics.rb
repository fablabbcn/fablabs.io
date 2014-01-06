class AddMetaToAcademics < ActiveRecord::Migration
  def change
    add_column :academics, :meta, :hstore
  end
end

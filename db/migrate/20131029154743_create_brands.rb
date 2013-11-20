class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :url
      t.string :workflow_state
      t.references :creator, index: true
      t.timestamps
    end
  end
end

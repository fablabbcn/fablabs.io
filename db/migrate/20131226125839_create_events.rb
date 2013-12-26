class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type, index: true
      t.string :name
      t.text :description
      t.belongs_to :lab, index: true
      t.belongs_to :creator, index: true
      t.datetime :starts_at, index: true
      t.datetime :ends_at

      t.timestamps
    end
  end
end

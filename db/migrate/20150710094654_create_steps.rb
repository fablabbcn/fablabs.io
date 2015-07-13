class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end

class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.integer :stars
      t.timestamps
    end
  end
end

class CreateCategorizes < ActiveRecord::Migration
  def change
    create_table :categorizes do |t|
      t.belongs_to :project, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end

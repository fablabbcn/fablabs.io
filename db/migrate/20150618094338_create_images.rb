class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :description
      t.string :file_id
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end

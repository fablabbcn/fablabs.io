class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :type, index: true
      t.string :title
      t.text :description
      t.attachment :image
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end

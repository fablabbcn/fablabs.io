class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :pageable, polymorphic: true, index: true
      t.string :ancestry, index: true
      t.string :name
      t.string :slug, index: true
      t.text :body
      t.belongs_to :creator, index: true

      t.timestamps
    end
  end
end

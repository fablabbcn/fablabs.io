class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :author, index: true
      t.string :ancestry
      t.references :commentable, polymorphic: true, index: true
      t.text :body
      t.timestamps
    end
    add_index :comments, :ancestry
  end
end

class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :body
      t.references :discussable, polymorphic: true, index: true
      t.references :creator, index: true
      t.string :workflow_state

      t.timestamps
    end
  end
end

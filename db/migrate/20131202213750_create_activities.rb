class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true
      t.string :action
      t.belongs_to :trackable, polymorphic: true, index: true
      t.datetime :created_at
    end
  end
end

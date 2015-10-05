class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end

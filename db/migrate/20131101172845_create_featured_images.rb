class CreateFeaturedImages < ActiveRecord::Migration
  def change
    create_table :featured_images do |t|
      t.string :src
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end

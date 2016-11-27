class PagesRevolt < ActiveRecord::Migration
  def up
    drop_table :pages

    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.integer :position, default: 0
      t.boolean :published, default: false

      t.timestamps
    end

    add_index :pages, :slug
  end

  def down
    drop_table :pages

    create_table "pages", force: true do |t|
      t.integer  "pageable_id"
      t.string   "pageable_type"
      t.string   "ancestry"
      t.string   "name"
      t.string   "slug"
      t.text     "body"
      t.integer  "creator_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "pages", ["creator_id"], name: "index_pages_on_creator_id", using: :btree
  end
end

class CreateLabTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_taggings do |t|
      t.references :lab, foreign_key: true
      t.references :lab_tag, foreign_key: true

      t.timestamps
    end
  end
end

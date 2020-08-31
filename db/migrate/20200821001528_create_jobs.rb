class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :apply_url
      t.boolean :is_featured
      t.boolean :is_verified
      t.references :user, foreign_key: true
      t.decimal :min_salary
      t.decimal :max_salary
      t.string :country_code

      t.timestamps
    end
  end
end

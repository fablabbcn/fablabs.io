class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.references :user, index: true
      t.references :lab, index: true
      t.integer :ordinal
      t.string :job_title
      t.string :email
      t.string :phone
      t.text :description
      t.date :started_on
      t.date :finished_on
      t.string :workflow_state
      t.references :creator, index: true
      t.timestamps
    end
    add_index :employees, :ordinal
  end
end

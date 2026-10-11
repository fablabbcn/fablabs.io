class AddDiscourseErrorsToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :discourse_errors, :string
  end
end

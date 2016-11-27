class AddDiscourseErrorsToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :discourse_errors, :string
  end
end

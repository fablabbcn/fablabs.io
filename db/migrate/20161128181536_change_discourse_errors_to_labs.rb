class ChangeDiscourseErrorsToLabs < ActiveRecord::Migration[4.2]
  def change
    change_column :labs, :discourse_errors, :text
  end
end

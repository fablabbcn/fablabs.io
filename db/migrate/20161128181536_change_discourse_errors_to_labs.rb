class ChangeDiscourseErrorsToLabs < ActiveRecord::Migration
  def change
    change_column :labs, :discourse_errors, :text
  end
end

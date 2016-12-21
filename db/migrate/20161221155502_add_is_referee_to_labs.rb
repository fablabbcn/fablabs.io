class AddIsRefereeToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :is_referee, :boolean, default: false
  end
end

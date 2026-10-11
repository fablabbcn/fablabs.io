class AddIsRefereeToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :is_referee, :boolean, default: false
  end
end

class AddRefereeToLabs < ActiveRecord::Migration
  def change
    add_reference :labs, :referee, index: true
  end
end

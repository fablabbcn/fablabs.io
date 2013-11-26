class AddBlurbToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :blurb, :string
  end
end

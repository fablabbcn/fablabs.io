class AddMoreFieldsToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :charter, :boolean, :default => false
    add_column :labs, :public, :boolean, :default => false
  end
end

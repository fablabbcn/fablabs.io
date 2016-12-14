class AddGeodataToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :geojson, :text
    add_column :organizations, :latitude, :float
    add_column :organizations, :longitude, :float
    add_column :organizations, :zoom, :integer
  end
end

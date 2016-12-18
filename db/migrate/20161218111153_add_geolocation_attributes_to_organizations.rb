class AddGeolocationAttributesToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :address_1, :string
    add_column :organizations, :address_2, :string
    add_column :organizations, :city, :string
    add_column :organizations, :county, :string
    add_column :organizations, :postal_code, :string
    add_column :organizations, :country_code, :string
    add_column :organizations, :subregion, :string
    add_column :organizations, :region, :string
    add_column :organizations, :address_notes, :text
    add_column :organizations, :reverse_geocoded_address, :text
  end
end

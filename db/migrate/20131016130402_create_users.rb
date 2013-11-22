class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :workflow_state
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password_digest

      t.string :avatar_src

      t.string :phone
      t.string :city
      t.string :country_code

      t.float  :latitude
      t.float  :longitude

      t.string :url
      t.date :dob
      t.text :bio

      t.string :my_locale
      t.string :my_timezone

      t.boolean :use_metric, default: true
      t.string :email_validation_hash

      t.timestamps

    end
  end
end

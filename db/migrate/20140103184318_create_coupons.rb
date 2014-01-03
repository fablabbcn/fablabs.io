class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.belongs_to :user, index: true
      t.string :description
      t.string :code, index: true, unique: true, null: false
      t.integer :value
      t.datetime :redeemed_at
      t.timestamps
    end
  end
end

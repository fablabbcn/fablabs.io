class AddFab10ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fab10_coupon_code, :string
    add_index :users, :fab10_coupon_code, unique: true#, nil: false
    add_column :users, :fab10_cost, :integer, default: 50000
    add_column :users, :fab10_claimed_at, :datetime

    User.includes(:employees).each do |u|
      u.generate_fab10_coupon_code
      u.save
    end
  end
end

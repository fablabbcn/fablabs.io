class AddEmailFallbackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_fallback, :string
  end
end

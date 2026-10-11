class AddEmailFallbackToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :email_fallback, :string
  end
end

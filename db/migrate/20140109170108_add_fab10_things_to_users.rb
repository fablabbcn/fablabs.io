class AddFab10ThingsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :fab10_attendee_id, :integer
    add_column :users, :fab10_email_sent, :boolean
  end
end

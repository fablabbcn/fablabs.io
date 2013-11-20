class CreateRecoveries < ActiveRecord::Migration
  def change
    create_table :recoveries do |t|
      t.references :user, index: true
      t.string :key
      t.string :ip
      t.string :workflow_state

      t.timestamps
    end
  end
end

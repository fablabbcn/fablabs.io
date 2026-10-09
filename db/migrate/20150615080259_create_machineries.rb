class CreateMachineries < ActiveRecord::Migration[4.2]
  def change
    create_table :machineries do |t|
      t.belongs_to :project, index: true
      t.belongs_to :device, index: true
    
      t.timestamps
    end
  end
end

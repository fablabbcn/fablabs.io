class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|

      t.belongs_to :project, index: true
      t.belongs_to :contributor, index: true
      t.datetime :last_contribution
      
      t.timestamps
    end
  end
end

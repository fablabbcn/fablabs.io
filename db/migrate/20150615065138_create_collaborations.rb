class CreateCollaborations < ActiveRecord::Migration[4.2]
  def change
    create_table :collaborations do |t|
      t.belongs_to :project, index: true
      t.belongs_to :collaborator, index: true
      t.datetime :last_collaboration

      t.timestamps
    end
  end
end

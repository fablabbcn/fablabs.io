class ImproveApprovalApplicationToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :improve_approval_application, :text
  end
end

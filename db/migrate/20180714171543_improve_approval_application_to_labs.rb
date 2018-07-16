class ImproveApprovalApplicationToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :improve_approval_application, :text
  end
end

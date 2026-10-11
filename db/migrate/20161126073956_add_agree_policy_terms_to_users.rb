class AddAgreePolicyTermsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :agree_policy_terms, :boolean, default: false
  end
end

class AddAgreePolicyTermsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agree_policy_terms, :boolean, default: false
  end
end

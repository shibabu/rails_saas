class AddCustomerIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :customer_id, :string
  end
end

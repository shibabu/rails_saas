class IndexUsersOnSubdomain < ActiveRecord::Migration
  def change
    add_index :users, :subdomain, unique: true
  end
end

class RenamePlanPriceToAmount < ActiveRecord::Migration
  def change
    rename_column :plans, :price, :amount
  end
end

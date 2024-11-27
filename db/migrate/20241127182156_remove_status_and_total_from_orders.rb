class RemoveStatusAndTotalFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :status, :string
    remove_column :orders, :total, :decimal
  end
end

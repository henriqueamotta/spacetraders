class AddAddressAndPlanetToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :address, :string
    add_column :orders, :planet, :string
  end
end

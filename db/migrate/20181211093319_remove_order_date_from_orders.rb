class RemoveOrderDateFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :order_date
  end
end

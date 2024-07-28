class AddTaxAndGrandTotalToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :tax_amount, :decimal
    add_column :orders, :grand_total, :decimal
  end
end

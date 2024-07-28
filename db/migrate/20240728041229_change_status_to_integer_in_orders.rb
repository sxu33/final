class ChangeStatusToIntegerInOrders < ActiveRecord::Migration[6.1]
  def up
    # Remove the old string column
    remove_column :orders, :status

    # Add the new integer column
    add_column :orders, :status, :integer, default: 0
  end

  def down
    # Remove the new integer column
    remove_column :orders, :status

    # Add the old string column
    add_column :orders, :status, :string
  end
end

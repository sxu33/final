class RemoveNewAndRecentlyUpdatedFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :new, :boolean
    remove_column :products, :recently_updated, :boolean
  end
end

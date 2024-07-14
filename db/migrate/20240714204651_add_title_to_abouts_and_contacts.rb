class AddTitleToAboutsAndContacts < ActiveRecord::Migration[7.1]
  def change
     add_column :abouts, :title, :string
    add_column :contacts, :title, :string
  end
end

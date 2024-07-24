class CreateTaxRates < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rates do |t|
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end

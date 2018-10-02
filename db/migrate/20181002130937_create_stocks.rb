class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.float :price
      t.float :open
      t.float :high
      t.float :low
    end
  end
end

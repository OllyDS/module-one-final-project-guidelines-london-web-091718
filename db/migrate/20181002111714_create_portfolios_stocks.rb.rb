class CreatePortfoliosStocks.rb < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios_stocks do |t|
      t.integer :portfolios_id
      t.integer :stocks_id
    end
  end
end

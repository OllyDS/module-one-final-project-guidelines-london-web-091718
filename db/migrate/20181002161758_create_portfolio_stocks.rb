class CreatePortfolioStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_stocks do |t|
      t.integer :portfolio_id
      t.integer :stock_id
    end
  end
end

class CreatePortfolios.rb < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.string :name
      t.float :cash
    end
  end
end

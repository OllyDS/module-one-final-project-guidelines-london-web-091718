class Portfolio < ActiveRecord::Base
  has_many :portfolio_stocks
  has_many :stocks, through: :portfolio_stocks

  # def quantity_of_stocks_as_hash
  #   stock_hash = {}
  #
  #   self.stocks.each do |stock|
  #     if stock_hash.include?(stock.name)
  #       stock_hash[stock] += 1
  #     else
  #       stock_hash[stock] = 1
  #     end
  #   end
  #   stock_hash
  # end

end

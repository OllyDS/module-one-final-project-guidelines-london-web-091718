class PortfolioStock < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock
end

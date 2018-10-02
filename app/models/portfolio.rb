class Portfolio < ActiveRecord::Base
  belongs_to :portfolio_stocks
  has_many :stocks, through: :portfolio_stocks
end

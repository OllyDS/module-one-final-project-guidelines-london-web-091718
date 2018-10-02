class Stock < ActiveRecord::Base
  belongs_to :portfolio_stocks
  has_many :portfolios, through: :portfolio_stocks
end

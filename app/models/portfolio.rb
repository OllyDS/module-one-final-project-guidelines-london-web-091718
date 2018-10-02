class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :stocks, through: :portfolio_stocks
end

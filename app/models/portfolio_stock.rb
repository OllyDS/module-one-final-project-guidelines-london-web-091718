class PortfolioStock < ActiveRecord::Base
  belongs_to :portfolio
  has_many :stocks
end

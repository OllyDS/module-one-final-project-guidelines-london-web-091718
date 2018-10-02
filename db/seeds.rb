p1 = Portfolio.create(name: "Sam", cash: 1000000)

s1 = Stock.create(name: "AAPL", price: 100.50, open: 99.00, high: 102.10, low: 98.60)

ps1 = PortfolioStock.create(portfolio_id: 1, stock_id: 1)

def welcome # Puts out welcome message
  puts "\nWelcome to the big leagues kiddo,
As it's your first day we'll start you off small.
Here's a few quid from the NHS pension pot to gamble on the markets.\n"
end

def portfolio_name
  print "\nGive yer Portfolio a name: "
end

def gets_portfolio_name
  portfolio_name = gets.chomp
  #Gets user input, creates Portfolio name, saves instance to .db
  if !portfolio_name.empty?
    Portfolio.where(name: portfolio_name).delete_all
    Portfolio.create(name: portfolio_name, cash: 25000.00)
  else
    Portfolio.create(name: portfolio_name, cash: 25000.00)
  end
  @portfolio_name = portfolio_name
end

def output_portfolio_name(input) #Outputs Portfolio name
  puts "\nHere is a list of stocks you can add to #{input}:\n"
end

def loop_1
  stocks_list_table   #Displays table of stocks available
  stock_info  #Asks user for stock Ticker
  stock_ticker = gets_stock_info.upcase  #User enters Ticker
  stock_hash = get_stock_from_api(stock_ticker)   #Gets stock API info
  create_stock_instance_from_hash(stock_hash)   #Saves to stock .db
  user_choice_1   #Asks user if they want to Buy or Return
  input = user_answer_1   #Gets user answer
  user_path_1(input)    #Buy menu or Return to stock table.
end

def create_stock_instance_from_hash(stock_hash)
  #Creates an instance of the stock and saves to the .db
  @stock_instance = Stock.create(stock_hash)
  @stock_instance
end

def stocks_list_table
  table = Terminal::Table.new :headings => ["Stock Name", "Ticker", "Stock Name", "Ticker"] do |t|
  t << ['Apple', 'AAPL', 'Amazon', 'AMZN']
  t << :separator
  t.add_row ['Microsoft', 'MSFT', 'Alphabet', 'GOOG']
  t.add_separator
  t.add_row ['Facebook', 'FB', 'Activision Blizzard', 'ATVI']
  t.add_separator
  t.add_row ['Cisco Systems', 'CSCO', 'Intel Corp', 'INTC']
  t.add_separator
  t.add_row ['Netflix Inc', 'NFLX', 'NVIDIA Corp', 'NVDA']
  t.add_separator
  t.add_row ['PepsiCo', 'PEP', 'Amgen', 'AMGN']
  t.add_separator
  t.add_row ['Broadcom', 'AVGO', 'QUALCOMM', 'QCOM']
  t.add_separator
  t.add_row ['Costco', 'COST', 'eBay', 'EBAY']
  t.add_separator
  t.add_row ['Tesla Inc', 'TSLA', 'Comcast Corp', 'CMCSA']
  t.add_separator
  t.add_row ['Adobe Systems', 'ADBE', 'Baidu Inc ADR', 'BIDU']
  t.add_separator
  t.add_row ['Symantec Corp', 'SYMC', 'Starbucks Corp', 'SBUX']
  end
  puts "\n#{table}\n"
end

def stock_info
  print "\nEnter the Ticker of a stock you want to get info on: "
end

def gets_stock_info
  gets.chomp
end

def user_choice_1
  print "Would you like to purchase some of this stock, or return to the menu?\n
Enter 'B' to Buy Stock or 'R' to Return: "
end

def loop_2   # Runs a loot to re-enter stock if invalid input
  input = user_answer_1
  user_path_1(input)
end

def error_message
  print "\nInvalid response!\n
Please enter a valid input: "
end

def user_answer_1 # B or R
  input = gets.chomp
  input
end

def user_path_1(input) # stock = stock hash
  if input.downcase == 'b'
    buy_stock_quantity
  elsif input.downcase == 'r'
    loop_1
  else
    error_message
    sleep(2)  #pause's to read the error
    loop_2
  end
end

# def get_portfolio_cash
#   @portfolio_cash = 0.00
#   pc = Portfolio.find_by(name: @portfolio_name)
#   @portfolio_cash = pc.cash
# end

def buy_stock_quantity #Asks the user for quantity to buy.
  pc = Portfolio.find_by(name: @portfolio_name)
  @portfolio_cash = pc.cash
  @name = @stock_instance[:name]
  @price = @stock_instance[:price]

  print"How much you wanna buy then?
Smallest is 1 share, but you're better than that...
Current cash balance is $#{@portfolio_cash}.
Don't spend it all at once junior!
\n
Stock Symbol:   #{@name}
Current Price:  $#{@price}
Quantity to Buy: "

  def gets_quantity # Asks for the quantity of shares to buy
    gets.chomp.to_f
    ####### SAVE TO PS.db ########
  end
end

def current_portfolio_cash
  stock_quantity = gets_quantity
  buy_value = stock_quantity * @price
  @portfolio_cash -= buy_value
  puts "WAHEY . Easy there big spender\nYour remaining cash: $#{@portfolio_cash.round(2)}\n"
end



# 17. 	PayPal Holdings    	PYPL
# 20. 	Gilead Sciences    	GILD
# 21. 	Booking Holdings   	BKNG
# 23.   T-Mobile US Inc	    TMUS
# 25.	  Micron Technology   MU
# 26.   Electronic Arts   	EA
# 29.   Western Digital     WDC
# 30.   Seagate Technology  STX
#

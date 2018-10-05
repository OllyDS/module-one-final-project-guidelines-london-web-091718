def welcome # Puts out welcome message
  @array_of_user_stocks = [] # initializes empty array
  system("clear")
  system 'figlet Stock Market Simulator'
  "Welcome to the big leagues kiddo,
As it's your first day we'll start you off small.
Here's a few quid from the NHS pension pot to gamble on the markets.\n".each_char do |c|
  sleep 0.05
  print c
  end
end

def portfolio_name
  "\nGive your Portfolio a name, and make it good!
We don't want it making our company look ****!: ".each_char do |c|
    sleep 0.05
    print c
  end
end

def gets_portfolio_name
  portfolio_name = gets.chomp
  #Gets user input, creates Portfolio name, saves instance to .db
  if !portfolio_name.empty?
    Portfolio.where(name: portfolio_name).delete_all
    pn = Portfolio.create(name: portfolio_name, cash: 25000.00)
  else
    pn = Portfolio.create(name: portfolio_name, cash: 25000.00)
  end
  @portfolio_hash = pn
  @portfolio_name = pn.name
end

# def output_portfolio_name(input) #Outputs Portfolio name
#   puts "\nHere is a list of stocks you can add to #{input}:\n"
# end

def loop_1
  stocks_list_table   #Displays table of stocks available
  stock_info  #Asks user for stock Ticker
  # The below code is the original master
  # stock_ticker = gets_stock_info.upcase  #User enters Ticker
  # stock_hash = get_stock_from_api(stock_ticker)   #Gets stock API info
  # create_stock_instance_from_hash(stock_hash)   #Saves to stock .db
  # user_choice_1   #Asks user if they want to Buy or Return
  # user_path_1    #Buy menu or Return to stock table.
end

def create_stock_instance_from_hash(stock_hash)
  #Creates an instance of the stock and saves to the .db
  @stock_instance = Stock.create(stock_hash)
  @stock_instance
end

def stocks_list_table
  system("clear")
  @table = Terminal::Table.new :headings => ["Stock Name".bold, "Ticker".bold, "Stock Name".bold, "Ticker".bold] do |t|
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
    t.add_separator
    t.add_row ['PayPal Holdings', 'PYPL', 'Gilead Sciences', 'GILD']
    t.add_separator
    t.add_row ['Booking Holdings', 'BKNG', 'T-Mobile US Inc', 'TMUS']
    t.add_separator
    t.add_row ['Micron Technology', 'MU', 'Electronic Arts', 'EA']
    t.add_separator
    t.add_row ['Western Digital', 'WDC', 'Seagate Technology', 'STX']
  end
  "\nHere is a list of stocks you can add to #{@portfolio_name}:\n".each_char do |c|
    sleep 0.05
    print c
  end
  puts"\n#{@table}\n"
end

def stock_info
  "\nEnter the Ticker of a stock you want to get info on: ".bold.each_char do |c|
      sleep 0.05
      print c
    end
end

def gets_stock_info ######### method to fix the invalid tickers
  @array_of_tickers = ['AAPL', 'AMZN', 'MSFT', 'GOOG', 'FB', 'ATVI', 'CSCO', 'INTC', 'NFLX', 'NVDA', 'PEP', 'AMGN', 'AVGO', 'QCOM', 'COST', 'EBAY', 'TSLA', 'CMCSA', 'ADBE', 'BIDU', 'SYMC', 'SBUX', 'PYPL', 'GILD', 'BKNG', 'TMUS', 'MU', 'EA', 'WDC', 'STX']
  user_input_ticker = gets.chomp.upcase
  if @array_of_tickers.include?(user_input_ticker)
    stock_hash = get_stock_from_api(user_input_ticker)
    create_stock_instance_from_hash(stock_hash)
    user_choice_1
    user_path_1
  else
    puts "Sorry! We couldn't find your stock Ticker in our database."
    print "Please insert a valid Ticker: "
    gets_stock_info
  end
end

# def gets_stock_info #original code and the above is experimenting
#   gets.chomp
# end

def user_choice_1
  "You gonna buy any of it then or just stare at it all day?\n
Enter 'B' to Buy Stock or 'R' to Return if you're scared: ".each_char do |c|
    sleep 0.05
    print c
  end
end

def error_message
  print "\nInvalid response!\n
That wasn't even an option! Enter a valid input: ".red.bold
end

def user_path_1 # stock = stock hash
  while input = gets.chomp# loop while getting user input
    case input.downcase
    when "b"
      buy_stock_quantity
      break # make sure to break so you don't ask again
    when "r"
      loop_1
      gets_stock_info ########added by Dina
      break # and again
    else
      error_message
    end
  end
end

def easter_egg
 "The Financial Markets brought to you by Dina, Olly and Steve.\n".each_char do |c|
   sleep 0.5
   print c
 end
end

def buy_stock_quantity #Asks the user for quantity to buy.
  system("clear")
  pc = Portfolio.find_by(name: @portfolio_name)
  @portfolio_cash = pc.cash
  @name = @stock_instance[:name]
  @price = @stock_instance[:price]

  "\nHow much you wanna buy then?
Smallest is 1 share, Largest is 1,000, Don't want you getting burnt on day 1.\n".each_char do |c|
    sleep 0.05
    print c
  end
  "\nCurrent cash balance is $#{@portfolio_cash.round(2)}.\n".bold.each_char do |c|
      sleep 0.05
      print c
    end
  "\nDon't spend it all at once junior!\n".each_char do |c|
      sleep 0.05
      print c
    end
  print "\n
  Stock Symbol:     " + "#{@name}".bold
  print "
  Current Price:    " + "$#{@price}".bold
  print "
  Quantity to Buy:  "

  def gets_quantity # Asks for the quantity of shares to buy
    gets.chomp.to_i
  end
end


def current_portfolio_cash
  stock_quantity = gets_quantity
  if stock_quantity > 1000
    stock_quantity = 1000
  end

  stock_quantity.times do
    @array_of_user_stocks << @stock_instance.name
  end

  @stock_hash = {}
  @array_of_user_stocks.each do |ticker|
    if @stock_hash.include?(ticker)
      @stock_hash[ticker] += 1
    else
      @stock_hash[ticker] = 1
    end
  end

  (1..stock_quantity).to_a.each do |i|
    PortfolioStock.create(portfolio: @portfolio_hash, stock: @stock_instance)
  end

  buy_value = stock_quantity * @price
  @portfolio_cash -= buy_value
  if @portfolio_cash > 0.0
    puts "\nWAHEY! Easy there big spender\nYour remaining cash is: $#{@portfolio_cash.round(2)}\n"
    db_portfolio_cash = Portfolio.find_by(name: @portfolio_name)
    db_portfolio_cash.update(cash: @portfolio_cash)
  else
    "\nOh dear, you've only gone and blown your BUDGET PUNK!\n
BIG BOSS, will DEAL with you Shortly!\n".each_char do |c|
  sleep 0.05
  print c
  end
    sleep(1)
    system 'figlet 3'
    sleep(1)
    system 'figlet 2'
    sleep(1)
    system 'figlet 1'
    sleep(1)
    system 'clear'
    system 'figlet YOURE FIRED!!!'
    wipe_everything_after_session
    exit
  end
end

####### commented out by Dina
# def user_portfolio
#   display_portfolio
# end

def continue_or_exit
  print "Do want to continue or exit?
Type 'C' to Continue, or 'E' to Exit: "
end

def gets_continue_or_exit
  gets.chomp
end

def exit_message
  puts "\nCalling it a day already? HAHAHA!!!
I knew you were weak! Get out of my sight!\n".red.bold
end

def user_path_2 # stock = stock hash
  while input = gets.chomp# loop while getting user input
    case input.downcase
    when "c"
      loop_1
      gets_stock_info ######addeded by dina
      current_portfolio_cash
      # user_portfolio #######commented out by Dina
      display_portfolio
      continue_or_exit
      user_path_2
      break # make sure to break so you don't ask again
    when "e"
      exit_message
      wipe_everything_after_session
      exit
      break # and again
    when "flatironschool"
      easter_egg
      wipe_everything_after_session
      exit
      break # and again
    else
      error_message
    end
  end
end

def display_portfolio
  table = Terminal::Table.new :title => "#{@portfolio_name}".bold, :headings => ['Stock Ticker'.bold, 'Stock Quantity'.bold] do |t|
    @stock_hash.each do |x, y|
      t <<  ["#{x}", "#{y}"]
      t << :separator
    end
    t.add_row ["Remaining Cash Balance: ".bold, "$#{@portfolio_cash.round(2)}".bold]
  end
  "\nHere is your current Portfolio:".each_char do |c|
      sleep 0.05
      print c
  end
  puts "\n#{table}\n"
end


#################################
def wipe_everything_after_session
  Stock.delete_all
  PortfolioStock.delete_all
  Portfolio.delete_all
end
##################################

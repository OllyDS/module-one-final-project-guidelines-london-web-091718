def welcome # Puts out welcome message
  @array_of_user_stocks = [] # initializes empty array
  system("clear")
  system 'figlet Stock Market Simulator'
  puts "\nWelcome to the big leagues kiddo,
As it's your first day we'll start you off small.
Here's a few quid from the NHS pension pot to gamble on the markets.\n"
end

def portfolio_name
  print "\nGive your Portfolio a name, and make it good!
We don't want it making our company look ****!: "
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
  stock_ticker = gets_stock_info.upcase  #User enters Ticker
  stock_hash = get_stock_from_api(stock_ticker)   #Gets stock API info
  create_stock_instance_from_hash(stock_hash)   #Saves to stock .db
  user_choice_1   #Asks user if they want to Buy or Return
  user_path_1    #Buy menu or Return to stock table.
end

def create_stock_instance_from_hash(stock_hash)
  #Creates an instance of the stock and saves to the .db
  @stock_instance = Stock.create(stock_hash)
  @stock_instance
end

def stocks_list_table
  system("clear")
  table = Terminal::Table.new :headings => ["Stock Name".bold, "Ticker".bold, "Stock Name".bold, "Ticker".bold] do |t|
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
  puts "\nHere is a list of stocks you can add to #{@portfolio_name}:
\n#{table}\n"
end

def stock_info
  print "\nEnter the Ticker of a stock you want to get info on: ".bold
end

def gets_stock_info
  gets.chomp
end

def user_choice_1
  puts "You gonna buy any of it then or just stare at it all day?\n".blue.bold
  print "Enter 'B' to Buy Stock or 'R' to Return if you're scared: ".bold
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
      break # and again
    else
      error_message
    end
  end
end

def buy_stock_quantity #Asks the user for quantity to buy.
  system("clear")
  pc = Portfolio.find_by(name: @portfolio_name)
  @portfolio_cash = pc.cash
  @name = @stock_instance[:name]
  @price = @stock_instance[:price]

  print"\nHow much you wanna buy then?
Smallest is 1 share, Largest is 1,000, Don't want you getting burnt on day 1.\n"
  puts "\nCurrent cash balance is $#{@portfolio_cash.round(2)}.".bold
  puts "Don't spend it all at once junior!\n"
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
  # @array_of_user_stocks << @stock_instance.name.times do |i|
  #   i.stock_quantity
  # end
  # add .times_do(stock_quantity) to end

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
    puts "\nWAHEY! Easy there big spender\nYour remaining cash is: $#{@portfolio_cash.round(2)}\n".bold
    db_portfolio_cash = Portfolio.find_by(name: @portfolio_name)
    db_portfolio_cash.update(cash: @portfolio_cash)
  else
    puts "Oh dear, you've only gone and blown your BUDGET PUNK!\n
BIG BOSS, will DEAL with you Shortly!"
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


def user_portfolio
  display_portfolio
end

def continue_or_exit
  print "Do want to continue or exit?
Type 'C' to Continue, or 'E' to Exit: ".blue
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
      current_portfolio_cash
      user_portfolio
      continue_or_exit
      user_path_2
      break # make sure to break so you don't ask again
    when "e"
      exit_message
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
      t <<  ["#{x}", "#{y}".blue]
      t << :separator
    end
    t.add_row ["Remaining Cash Balance: ".bold, "$#{@portfolio_cash.round(2)}".bold.blue]
  end
  puts "\nHere is your current Portfolio:
\n#{table}\n".bold
end


#################################
def wipe_everything_after_session
  Stock.delete_all
  PortfolioStock.delete_all
  Portfolio.delete_all
end
##################################

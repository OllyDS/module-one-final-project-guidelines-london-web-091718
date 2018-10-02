def username # Requests users name
  print "\nPlease enter your name: "
end

def gets_username # Gets users name
  username = gets.chomp
  # User.create(name: username)
  username
end

def welcome # Puts out welcome message
  puts "\nHey #{gets_username}! Welcome to your first day on the job!\n
Word is that you're a bit of a hotshot, so the company is giving you $1,000,000 to start with.\n
Check out our analysts list of hottest tech stocks which you can add to your Portfolio.\n"
end

def portfolio_name
  print "\nPlease name your Portfolio: "
end

def gets_portfolio_name
  portfolio_name = gets.chomp
  portfolio_name
end

def output_portfolio_name(input)
  puts "\nHere is a list of stocks you can add to #{input}:\n"
end

def loop_1
  stocks_list_table
  stock_info
  stock_ticker = gets_stock_info
  stock_hash = get_stock_from_api(stock_ticker)
  create_stock_instance_from_hash(stock_hash)
  user_choice_1
  input = user_answer_1
  user_path_1(input, stock_ticker)
end

def create_stock_instance_from_hash(stock_hash)
  Stock.create(stock_hash)
end

def stocks_list_table
  table = Terminal::Table.new :headings => ["Stock Name", "Ticker", "Stock Name", "Ticker"] do |t|
  t << ['Apple', 'AAPL', 'Amazon', 'AMZN']
  t << :separator
  t.add_row ['Microsoft', 'MFST', 'Alphabet', 'GOOG']
  t.add_separator
  t.add_row ['Facebook', 'FB', 'Activision Blizzard', 'ATVI']
  t.add_separator
  t.add_row ['Cisco Systems', 'CSCO', 'Intel Corp', 'INTC']
  t.add_separator
  t.add_row ['Netflix Inc', 'NFLX', 'NVIDIA Corp', 'NVDA']
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

def user_path_1(input, stock)
  if input.downcase == 'b'
    buy_stock_from_api(stock)
  elsif input.downcase == 'r'
    loop_1
  else
    error_message
    sleep(2)  #pause's to read the error
    loop_2
  end
end



# 9.  	Netflix Inc	        NFLX
# 10. 	NVIDIA Corp	        NVDA
# 11. 	Comcast Corp	      CMCSA
# 12. 	PepsiCo    	        PEP
# 13. 	Amgen    	          AMGN
# 14. 	Adobe Systems    	  ADBE
# 15. 	Broadcom     	      AVGO
# 16. 	QUALCOMM     	      QCOM
# 17. 	PayPal Holdings    	PYPL
# 18. 	Baidu Inc ADR	      BIDU
# 19. 	Costco	            COST
# 20. 	Gilead Sciences    	GILD
# 21. 	Booking Holdings   	BKNG
# 22. 	Starbucks Corp	    SBUX
# 23.   T-Mobile US Inc	    TMUS
# 24.   Tesla Inc	          TSLA
# 25.	  Micron Technology   MU
# 26.   Electronic Arts   	EA
# 27.   eBay                EBAY
# 28.   Symantec Corp	      SYMC
# 29.   Western Digital     WDC
# 30.   Seagate Technology  STX
#

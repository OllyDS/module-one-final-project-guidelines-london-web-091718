require 'rest-client'
require 'json'
require 'pry'

def get_stock_from_api(gets_stock_info)
  response_string = RestClient.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{gets_stock_info}&apikey=93W5SU6PN3ZE4DQV")
  response_hash = JSON.parse(response_string)

  name = response_hash.map {|k, v| v["01. symbol"]}
  price = response_hash.map {|k, v| v["05. price"]}
  open_px = response_hash.map {|k, v| v["02. open"]}
  high_px = response_hash.map {|k, v| v["03. high"]}
  low_px = response_hash.map {|k, v| v["04. low"]}

  puts <<-STRING

  Stock Symbol:           #{name[0]}
  Current Price:          $#{price[0].to_f.round(2)}
  Today's Opening Price:  $#{open_px[0].to_f.round(2)}
  Today's Highest Price:  $#{high_px[0].to_f.round(2)}
  Today's Lowest Price:   $#{low_px[0].to_f.round(2)}

  STRING

  return {
    name: name[0],
    price: price[0].to_f.round(2),
    open: open_px[0].to_f.round(2),
    high: high_px[0].to_f.round(2),
    low: low_px[0].to_f.round(2)
  }

end

# def buy_stock_from_api(buying_stock)
#   response_string = RestClient.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{buying_stock}&apikey=93W5SU6PN3ZE4DQV")
#   response_hash = JSON.parse(response_string)
#
#   name = response_hash.map {|k, v| v["01. symbol"]}
#   price_s = response_hash.map {|k, v| v["05. price"]}
#   @price = price_s[0].to_f.round(2)
#   quantity = 1
#   @portfolio_cash = 25000.00 # CHANGE MEEEEEEE
#
#   print"
# How much you wanna buy then?
# Smallest is 1 share, but you're better than that...
# Current cash balance is $#{@portfolio_cash}.
# Don't spend it all at once junior!
# \n
# Stock Symbol:   #{name[0]}
# Current Price:  $#{@price}
#
# Quantity to Buy: "
#
#   def gets_quantity # Asks for the quantity of shares to buy
#     var = gets.chomp
#     var.to_f
#   end
#
#
#   def current_portfolio_cash
#     stock_quantity = gets_quantity
#     buy_value = stock_quantity * @price
#     @portfolio_cash -= buy_value
#     puts "WAHEY - Easy there big spender\nYour remaining cash: $#{@portfolio_cash}\n"
#   end
#
# end

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

  system("clear")

  puts"   Stock Symbol:           " + "#{name[0]}".bold
  puts"   Current Price:          " + "$#{price[0].to_f.round(2)}".bold
  puts"   Today's Opening Price:  " + "$#{open_px[0].to_f.round(2)}".bold
  puts"   Today's Highest Price:  " + "$#{high_px[0].to_f.round(2)}".bold
  puts"   Today's Lowest Price:   " + "$#{low_px[0].to_f.round(2)}\n".bold

  return {
    name: name[0],
    price: price[0].to_f.round(2),
    open: open_px[0].to_f.round(2),
    high: high_px[0].to_f.round(2),
    low: low_px[0].to_f.round(2)
  }

end

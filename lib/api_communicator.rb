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
end

def user_choice_1
  print <<-STRING
Would you like to purchase some of this stock, or return to the menu?
Enter 'B' to Buy Stock or 'R' to Return:
STRING
end

def user_answer_1
  gets.chomp
end

def user_path_1
  if user_answer_1 == 'B'
    #code to buy stock
  elsif user_answer_1 == 'R'
    #go into loop_1
  else
    puts "Invalid Response!"
  end
end

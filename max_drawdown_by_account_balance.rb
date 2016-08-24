# How to use:
# run cmd: "ruby csv_parse.rb name_of_csv_file.csv"

return_per_contract = []
File.read("./#{ARGV[0]}").lines.each do |row|
  return_per_contract << row.to_i
end

account_balance = 0
running_max_account_balance = 0
running_min_account_balance = 0
running_max_drawdown = 0
running_max_upside = 0
return_per_contract.each_with_index do |current_contract, index|
  account_balance += current_contract
  running_max_account_balance = account_balance if account_balance > running_max_account_balance
  running_min_account_balance = account_balance if account_balance < running_min_account_balance
  if (account_balance - running_max_account_balance) < running_max_drawdown
    running_max_drawdown = (account_balance - running_max_account_balance)
  end
  if (account_balance - running_min_account_balance) > running_max_upside
    running_max_upside = (account_balance - running_min_account_balance)
  end
end

puts "account balance: #{account_balance}"
puts "running max account balance: #{running_max_account_balance}"
puts "running max drawdown: #{running_max_drawdown}"
puts "running min account balance: #{running_min_account_balance}"
puts "running max upside: #{running_max_upside}"

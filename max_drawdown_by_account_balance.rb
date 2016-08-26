# How to use:
# run cmd: "ruby max_drawdown_by_account_balance.rb name_of_csv_file.csv"

account_balances = []
File.read("./#{ARGV[0]}").lines.each do |row|
  account_balances << row.to_i
end

running_max_account_balance = 0
running_min_account_balance = 0
running_max_drawdown = 0
running_max_upside = 0
running_max_drawdown_perc = nil
account_balances.each_with_index do |account_balance, index|
  running_max_account_balance = account_balance if account_balance > running_max_account_balance
  running_min_account_balance = account_balance if account_balance < running_min_account_balance
  if (account_balance - running_max_account_balance) < running_max_drawdown
    running_max_drawdown = (account_balance - running_max_account_balance)
    running_max_drawdown_perc = (running_max_drawdown.to_f/(account_balance - running_max_drawdown)) * 100 if (account_balance - running_max_drawdown) != 0
  end
  if (account_balance - running_min_account_balance) > running_max_upside
    running_max_upside = (account_balance - running_min_account_balance)
  end
end



puts "account balance: $#{account_balances.last}"
puts "running max account balance: $#{running_max_account_balance}"
puts "running max drawdown: $#{running_max_drawdown}"
puts "running max drawdown: #{running_max_drawdown_perc}%"
puts "running min account balance: $#{running_min_account_balance}"
puts "running max upside: $#{running_max_upside}"

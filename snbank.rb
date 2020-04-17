# authenticate login details
def authentication(user_name, pass_word)
  db_name = false
  db_pwd = false
  File.open("staff.txt").readlines.each do |line|
    if line.split(":").first === "username"
      db_name = true if line.split.last === user_name
    elsif line.split(":").first === "password"
      db_pwd = true if line.split.last === pass_word
    end
  end
  if (db_name && db_pwd) == true
    return true
  else
    return false
  end
end

#bank function
def bank()
  puts "---------Welcome, please select an option!--------"
  puts "1. Create new bank account"
  puts "2. Check Account details"
  puts "3. Logout"
  puts "-------------------------------------------------- \n"
  bank_option = gets.chomp.to_i
  if bank_option == 1
    dbase = File.open("customer.txt", "a+")
    puts "kindly provide the following details \t"
    puts "Enter account name: \n"
    account_name = gets.chomp
    dbase.puts account_name
    puts "Enter account opening balance: \n"
    opening_balance = gets.chomp
    dbase.puts opening_balance
    puts "Specify account type(savings or current) \n"
    account_type = gets.chomp
    while account_type != "savings" and account_type != "current"
      puts "You entered an invalid account type. Please ty again"
      account_type = gets.chomp()
    end
    dbase.puts account_type
    puts "Enter email address: \n"
    account_email = gets.chomp
    dbase.puts account_email
    account_number = rand(10000000000)
    dbase.puts account_number
    dbase.close
    puts "Your new account number is : #{account_number}"
    bank()
  elsif bank_option == 2
    puts "Enter customer's account number below: \n"
    user_acct_input = gets.chomp
    account_num_in_db = 0
    found = false
    contents = File.open("customer.txt", "r") { |file| file.read }
    customer_txt = contents.split(" ")
    customer_txt.each_with_index do |item, index|
      if (item == user_acct_input)
        account_num_in_db += index
        found = true
      end
    end
    if found
      puts "---------------Your account details are---------------"
      puts "Account Name: #{customer_txt[account_num_in_db - 4]}"
      puts "Opening Balance: #{customer_txt[account_num_in_db - 3]}"
      puts "Account type: #{customer_txt[account_num_in_db - 2]}"
      puts "Account email: #{customer_txt[account_num_in_db - 1]}"
      puts "Account Number: #{customer_txt[account_num_in_db]}"
      puts "-------------------------------------------------------"
    else
      puts "Sorry, Invalid account details"
    end
    bank()
  else
    #delete user session file
  end
end

puts "****Welcome to snbank****"
puts "1.Staff Login"
puts "2.Close App"

staff_input = gets.chomp.to_i
if staff_input == 1
  puts "Enter your Login details please"
  puts "Username: \n"
 
  user_name = gets.chomp.to_s
  puts "Password: \n"

  pass_word = gets.chomp.to_s
  #check if staff is saved in our staff.txt file
  check_login = authentication(user_name, pass_word)
  if check_login
    #save user session
    File.open("./user_session.txt", "w") { |file| file.puts user_name + "+" + pass_word }
    bank()
  elsif check_login == false
    puts "Sorry, login failed! please try again"
  end
elsif staff_input == 2
  puts "Goodbye!"
end

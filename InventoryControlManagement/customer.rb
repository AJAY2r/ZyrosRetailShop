class Customer

  attr_accessor :applied_discount

  # initialize the user object with percentage discount
  def initialize
    self.applied_discount = 0
  end

  # Select customer 
  def self.select_customer_type
    puts "\e[H\e[2J"
    puts "|=====================================================|"
    puts "| Customer type       . Option                        |"
    puts "|=====================================================|"
    Customer.customer_types.each do |opt, customer_type|
    puts "| #{Util.format_string(customer_type, 'customer_type')}   .    #{Util.format_string(opt, 'option')}  |"
    end
    puts "|=====================================================|"
    puts "| Press Q to exit from system.                        |"
    puts "|=====================================================|"
    puts "\n"
    puts "....Please select customer type for final billing?..."
    
    while true
      user_option = gets.chomp
      customer_type = Customer.customer_types[user_option.capitalize]
      abort("Thanks for visiting....") if user_option.capitalize == 'Q'
      break if customer_type
      puts "Not a valid customer!" if customer_type.nil?
    end
    puts "Cashier selected customer option -->  #{customer_type}"
    puts ""
    Customer.customer_discount_percentage[customer_type]

  end

  private

  # customer discount based on type
  def self.customer_discount_percentage
    {"Employee" => 30, "Affiliate" => 10, "Value customer" => 5, "Customer" => 0}
  end
  # customer type as per logic
  def self.customer_types
    {"E" => "Employee", "A" => "Affiliate", "V" => "Value customer", "C" => "Customer"}
  end
  

end
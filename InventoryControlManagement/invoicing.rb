class Invoicing
  attr_accessor :total_discount, :customer_discount, :total_bill, :amount_to_pay, :goods_list

  #prepare invoice
  def initialize
    self.goods_list = InventoryCatalog.get_goods_list
    self.customer_discount = Customer.select_customer_type
    self.total_bill = 0
    self.total_discount = DiscountCalculator.new
    self.amount_to_pay = 0
  end

  # display blue print of items then calcualte amount and display final invoice 
  def generate_invoice
    # showing the item menu
    blue_print
    # calculating discount based on customer type
    self.total_discount.calculate_discount(self)
    # print final invoice
    print_final_invoice
  end

  # display goods to customer
  def blue_print
    puts ""
    puts "|=====================================================|"
    puts "| Category         |  Item              |  Price      |"
    puts "|=====================================================|"
    goods_list.each do |category, item_price|
      item_price.each do |item, price|
        puts "| #{Util.format_string(category, 'category')} |  #{Util.format_string(item, 'item')}  |  $ #{Util.format_string(price.to_s, 'price')}|"
      end
    end
    puts "|=====================================================|"
    puts ""
    puts "Generating bill...."
    sleep 1/2
  end

  # prine final invoce to customer 
  def print_final_invoice
    puts "\e[H\e[2J"
    # add header
    puts "|====================================================================================================|"
    puts "|                                                                                                    |" 
    puts "|                                  *** Zyros Retail Shop ***                                         |"
    puts "|                                                                                                    |" 
    puts "|====================================================================================================|"
    puts "| Bill To:                                                                             Invoce no. 34 |"
    puts "| Ajay Singh                                                                         Date #{Time.now.strftime("%d.%m.%Y").ljust(10)} |"
    puts "|                                                                                    --------------- |" 
    puts "|                                                                                     Esten Block 12 |"
    puts "|                                                                                      West cost. MP |"
    puts "|                                                                                      ACN 1234789ef |"
    puts "|====================================================================================================|"
    puts "|-------------------------------------- Invoice detail ----------------------------------------------|"
    puts "|====================================================================================================|"
    puts "| Category                            |  Item                                       |  Price($)      |"
    puts "|====================================================================================================|"
    goods_list.each do |category, item_price|
      item_price.each do |item, price|
        puts "| #{Util.format_string(category, 'category_invoice')} |  #{Util.format_string(item, 'item_invoice')}  |  $ #{Util.format_string(sprintf('%.2f',price).to_s, 'price_invoice')}|"
      end
    end
    puts "|====================================================================================================|"
    puts "|-------------------------------------- Final Invoice -----------------------------------------------|"
    puts "|====================================================================================================|"
    # end header
    puts "| Total payable amount:                                                                $ #{sprintf('%.2f',total_bill).to_s.ljust(7)}     |"
    puts "| Total discount %#{customer_discount.to_s.rjust(2)}:                                                                  $ #{sprintf('%.2f',total_discount.total_percentage_discount_apllied_to_bill).to_s.ljust(7)}     |"
    puts "| Total $100 discount $5:                                                              $ #{sprintf('%.2f',total_discount.total_hundred_dollor_discount_apllied_to_bill).to_s.ljust(7)}     |"
    puts "| Total Saving:                                                                        $ #{sprintf('%.2f',total_discount.total_discount_apllied_to_bill).to_s.ljust(7)}     |"
    puts "|------------------------------                                                        --------------|"
    puts "| Total payable after discount:                                                        $ #{sprintf('%.2f',amount_to_pay).to_s.ljust(7)}     |"
    puts "|====================================================================================================|"
    puts "|-------------------------------- Thanks for business with us ---------------------------------------|"
    puts "|====================================================================================================|"
  end


end

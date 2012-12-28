class DiscountCalculator
  attr_accessor  :total_discount_apllied_to_bill, :total_percentage_discount_apllied_to_bill, :total_hundred_dollor_discount_apllied_to_bill

  # preparing the discount object as per discount logic
  def initialize
    self.total_discount_apllied_to_bill = 0
    self.total_percentage_discount_apllied_to_bill = 0
    self.total_hundred_dollor_discount_apllied_to_bill = 0
  end

  # going to calculate discounts those are pertinent
  def calculate_discount(invoice)
    total_percentage_base_discount_system_will_offer = 0
    invoice.goods_list.each do |category, item_price|
      item_price.each do |item, price|
        total_percentage_base_discount_system_will_offer += price unless InventoryCatalog.no_percentage_discount(category)
        invoice.total_bill += price
      end
    end
    calculate_percentage_base_discount_price(total_percentage_base_discount_system_will_offer, invoice)
    self.total_discount_apllied_to_bill += self.total_percentage_discount_apllied_to_bill
    self.total_discount_apllied_to_bill += calculate_every_hundred_dollor_discount(invoice.total_bill)
    invoice.amount_to_pay = (invoice.total_bill - total_discount_apllied_to_bill)
  end

  private

  # as per customer type get discount percentage.
  def calculate_percentage_base_discount_price(total_percentage_base_discount_system_will_offer, invoice)
    self.total_percentage_discount_apllied_to_bill = total_percentage_base_discount_system_will_offer * invoice.customer_discount / 100
  end

  # as per $100 rule
  def calculate_every_hundred_dollor_discount(total_bill)
    self.total_hundred_dollor_discount_apllied_to_bill = (total_bill - (total_bill % 100))/100 * 5
  end

end
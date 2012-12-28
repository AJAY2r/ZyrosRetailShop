require 'simplecov'
SimpleCov.start
require './test_helper'
class InvoiceGenerationTest < Test::Unit::TestCase

  # setup goods list 
  def setup
    InventoryCatalog.expects(:get_goods_list).
      returns({"electronics" => {"LCD" => 100, "home theater " => 45, "light" => 7}, "groceries" => {"milk" => 2, "bread" => 3, "sugar" => 5}, "furniture" => {"chair" => 10, "tabel" => 23, "beans-bag" => 14}, "dressing" => {"belt" => 3, "Jacket" => 16}})
  end

  # test invoice generation if customer is a employee
  def test_invoice_for_employee_customer
    Customer.expects(:gets).returns('E')
    invoice = Invoicing.new
    invoice.generate_invoice
    assert_equal 228, invoice.total_bill
    assert_equal 30, invoice.customer_discount
    assert_equal 65, invoice.total_discount.total_percentage_discount_apllied_to_bill
    assert_equal 10, invoice.total_discount.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 75, invoice.total_discount.total_discount_apllied_to_bill
    assert_equal 153, invoice.amount_to_pay
  end

  # test invoice generation if customer is a value customer
  def test_invoice_for_value_customer
    Customer.expects(:gets).returns('V')
    invoice = Invoicing.new
    invoice.generate_invoice
    assert_equal 228, invoice.total_bill
    assert_equal 5, invoice.customer_discount
    assert_equal 10, invoice.total_discount.total_percentage_discount_apllied_to_bill
    assert_equal 10, invoice.total_discount.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 20, invoice.total_discount.total_discount_apllied_to_bill
    assert_equal 208, invoice.amount_to_pay
  end

  # test invoice generation if customer is a affiliate
  def test_invoice_for_Affiliate_customer
    Customer.expects(:gets).returns('A')
    invoice = Invoicing.new
    invoice.generate_invoice
    assert_equal 228, invoice.total_bill
    assert_equal 10, invoice.customer_discount
    assert_equal 21, invoice.total_discount.total_percentage_discount_apllied_to_bill
    assert_equal 10, invoice.total_discount.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 31, invoice.total_discount.total_discount_apllied_to_bill
    assert_equal 197, invoice.amount_to_pay
  end
  
  # test invoice generation if customer is a customer
  def test_invoice_for_normal_customer
    Customer.expects(:gets).returns('C')
    invoice = Invoicing.new
    invoice.generate_invoice
    assert_equal 228, invoice.total_bill
    assert_equal 0, invoice.customer_discount
    assert_equal 0, invoice.total_discount.total_percentage_discount_apllied_to_bill
    assert_equal 10, invoice.total_discount.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 10, invoice.total_discount.total_discount_apllied_to_bill
    assert_equal 218, invoice.amount_to_pay
  end

end
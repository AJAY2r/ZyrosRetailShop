require 'simplecov'
SimpleCov.start
require './test_helper'
require 'ostruct'
class DiscountCalculateTest < Test::Unit::TestCase
  # setup goods list 
  def setup
    InventoryCatalog.stubs(:get_goods_list).returns({"electronics" => {"LCD" => 100, "home theater " => 45, "light" => 7}, "groceries" => {"milk" => 2, "bread" => 3, "sugar" => 5}, "furniture" => {"chair" => 10, "tabel" => 23, "beans-bag" => 14}, "dressing" => {"belt" => 3, "Jacket" => 16}})
  end

  # calculate discount as per Initial state
  def test_discount
    discount_calcutator = DiscountCalculator.new
    assert_equal 0, discount_calcutator.total_discount_apllied_to_bill
    assert_equal 0, discount_calcutator.total_percentage_discount_apllied_to_bill
    assert_equal 0, discount_calcutator.total_hundred_dollor_discount_apllied_to_bill
  end

  # calculate discount if customer is affiliated
  def test_get_discount_for_affiliate
    Invoicing.expects(:new).returns(OpenStruct.new(:goods_list => InventoryCatalog.get_goods_list,:customer_discount => Customer.customer_discount_percentage["Affiliate"], :total_bill => 0,:total_discount => DiscountCalculator.new))
    invoice = Invoicing.new
    discount_calcutator = DiscountCalculator.new
    discount_calcutator.calculate_discount(invoice)
    assert_equal 228, invoice.total_bill
    assert_equal 10,  discount_calcutator.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 21,  discount_calcutator.total_percentage_discount_apllied_to_bill
    assert_equal 31,  discount_calcutator.total_discount_apllied_to_bill
    assert_equal 197, invoice.amount_to_pay
  end

  # calculate discount if customer is 2 years old
  def test_get_discount_for_value_customer
    Invoicing.expects(:new).returns(OpenStruct.new(:goods_list => InventoryCatalog.get_goods_list,:customer_discount => Customer.customer_discount_percentage["Value customer"], :total_bill => 0,:total_discount => DiscountCalculator.new))
    invoice = Invoicing.new
    discount_calcutator = DiscountCalculator.new
    discount_calcutator.calculate_discount(invoice)
    assert_equal 228, invoice.total_bill
    assert_equal 10,  discount_calcutator.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 10,  discount_calcutator.total_percentage_discount_apllied_to_bill
    assert_equal 20,  discount_calcutator.total_discount_apllied_to_bill
    assert_equal 208, invoice.amount_to_pay
  end
  
  # calculate discount if customer is an employee
  def test_get_discount_for_employee
    Invoicing.expects(:new).returns(OpenStruct.new(:goods_list => InventoryCatalog.get_goods_list,:customer_discount => Customer.customer_discount_percentage["Employee"], :total_bill => 0,:total_discount => DiscountCalculator.new))
    invoice = Invoicing.new
    discount_calcutator = DiscountCalculator.new
    discount_calcutator.calculate_discount(invoice)
    assert_equal 228, invoice.total_bill
    assert_equal 10,  discount_calcutator.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 65,  discount_calcutator.total_percentage_discount_apllied_to_bill
    assert_equal 75,  discount_calcutator.total_discount_apllied_to_bill
    assert_equal 153, invoice.amount_to_pay
  end

  # calculate discount if customer is a normal customer
  def test_get_discount_for_normal_customer
    Invoicing.expects(:new).returns(OpenStruct.new(:goods_list => InventoryCatalog.get_goods_list,:customer_discount => Customer.customer_discount_percentage["Customer"], :total_bill => 0,:total_discount => DiscountCalculator.new))
    invoice = Invoicing.new
    discount_calcutator = DiscountCalculator.new
    discount_calcutator.calculate_discount(invoice)
    assert_equal 228, invoice.total_bill
    assert_equal 10,  discount_calcutator.total_hundred_dollor_discount_apllied_to_bill
    assert_equal 0,  discount_calcutator.total_percentage_discount_apllied_to_bill
    assert_equal 10,  discount_calcutator.total_discount_apllied_to_bill
    assert_equal 218, invoice.amount_to_pay
  end
end
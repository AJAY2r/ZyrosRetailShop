require 'simplecov'
SimpleCov.start
require './test_helper'
class CustomerTest < Test::Unit::TestCase
  # test Initial customer
  def test_initialize
    customer = Customer.new
    assert_equal 0, customer.applied_discount
  end

  # test customer type based on input
  def test_customer_types
    customer_hash = Customer.customer_types
    assert_equal "Employee", customer_hash["E"]
    assert_equal "Affiliate", customer_hash["A"]
    assert_equal "Value customer", customer_hash["V"]
    assert_equal "Customer", customer_hash["C"]
  end

  # test customer type discount percentage
  def test_select_customer_type_discount_percentage
    Customer.expects(:gets).returns('E')
    assert_equal 30, Customer.select_customer_type
    Customer.expects(:gets).returns('A')
    assert_equal 10, Customer.select_customer_type
    Customer.expects(:gets).returns('V')
    assert_equal 5, Customer.select_customer_type
    Customer.expects(:gets).returns('C')
    assert_equal 0, Customer.select_customer_type
  end
end
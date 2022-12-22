require_relative "../exchange_function"
require "test/unit"

class TestUpdateRow < Test::Unit::TestCase
  def test_adds_extra_entries
    exchange_function = ExchangeFunction.new()
    input = {
      "testing1" => "123",
      "testing2" => "123",
    }
    output = exchange_function.update_row(input)
    assert_equal(4, output.length())
  end

  def test_removes_unwanted_entries
    exchange_function = ExchangeFunction.new()
    input = {
      "testing1" => "123",
      "testing2" => "123",
      "testing3" => "123",
      "testing4" => "123",
      "testing5" => "123",
      "testing6" => "123",
    }
    output = exchange_function.update_row(input)
    assert_equal(4, output.length())
  end

  def test_keeps_relevent_entries
    exchange_function = ExchangeFunction.new()
    input = {
      "id" => "1",
      "value" => "999",
      "currency" => "123",
    }
    output = exchange_function.update_row(input)
    assert_equal(input[:id], output[0])
    assert_equal(input[:value], output[1])
    assert_equal(input[:currency], output[2])
  end

  def test_new_order_created
    exchange_function = ExchangeFunction.new()
    input = {
      "value" => "999",
      "currency" => "123",
      "id" => "1",
    }
    output = exchange_function.update_row(input)
    assert_equal(input[:id], output[0])
    assert_equal(input[:value], output[1])
    assert_equal(input[:currency], output[2])
  end
end

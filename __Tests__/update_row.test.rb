require_relative "../services/csv_service"
require "test/unit"

class MockAPI
  def convert_value_to_euro(current_currency, current_value)
    return 1
  end
end

class TestUpdateRow < Test::Unit::TestCase
  def test_adds_extra_entries
    mock_api = MockAPI.new()
    exchange_function = CSVService.new(mock_api)
    input = {
      "testing1" => "123",
      "testing2" => "123",
    }
    output = exchange_function.update_row(input)
    assert_equal(4, output.length())
  end

  def test_removes_unwanted_entries
    mock_api = MockAPI.new()
    exchange_function = CSVService.new(mock_api)
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
    mock_api = MockAPI.new()
    exchange_function = CSVService.new(mock_api)
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
    mock_api = MockAPI.new()
    exchange_function = CSVService.new(mock_api)
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

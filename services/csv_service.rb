require "csv"
require "uri"
require "net/http"
require "json"
require_relative "./api_service"

class CSVService
  def initialize(api_service)
    @api_service = api_service
  end

  # Converts a file into the desired format in the ./Converted directory
  def convert_csv_file(csv_file_path)
    euro_hashmap = make_euro_conversion_hashmap(csv_file_path)
    rows = CSV.table(csv_file_path)
    new_rows = []
    headers = ["id", "initial_value", "initial_currency", "euro_value"]
    new_rows.push(headers)
    rows.each { |row| new_rows.push(update_row(row, euro_hashmap)) }

    # Update file path to be in the Converted directory
    csv_file_path["ToConvert"] = "Converted"
    
    File.write(csv_file_path, new_rows.map(&:to_csv).join)
  end

  # Converts a file into list of desired currencies
  # Creates a hashmap of converson rates using API for each currency
  def make_euro_conversion_hashmap(csv_file_path)
    rows = CSV.table(csv_file_path)
    currencies = []
    rows.each { |row| currencies.push(row[:currency]) }
    return @api_service.get_cenversion_rates_to_euro(currencies)
  end

  # Creates a new row
  # Adding only necessary columns
  # Creating the newly converted euro column from euro conversion hashmap
  def update_row(row, euro_hashmap)
    key = "EUR#{row[:currency].upcase}"
    exchange_rate = euro_hashmap[key]
    if !exchange_rate
      exchange_rate = 1
    end
    new_rate = row[:value] / exchange_rate
    new_row = []
    new_row.push(row[:id], row[:value], row[:currency], new_rate)
    return new_row
  end
end

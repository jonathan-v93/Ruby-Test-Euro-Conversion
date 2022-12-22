require "csv"
require "uri"
require "net/http"
require "json"

class ExchangeFunction

  # Gets file names of all files in the ./ToConvert directory and converts each file
  def convert_all()
    Dir.entries("./ToConvert").each { |file_path|
      if file_path.include? ".csv"
        convert_file("./ToConvert/" + file_path)
      end
    }
  end

  # Converts a file into the desired format in the ./Converted directory
  def convert_file(csv_file_path)
    rows = CSV.table(csv_file_path)
    new_rows = []

    headers = ["id", "initial_value", "initial_currency", "euro_value"]
    new_rows.push(headers)
    rows.each { |row| new_rows.push(update_row(row)) }

    # Update file path to be in the Converted directory
    csv_file_path["ToConvert"] = "Converted"

    File.write(csv_file_path, new_rows.map(&:to_csv).join)
  end

  # Creates a new row
  # Adding only necessary columns
  # Creating the newly converted euro column
  def update_row(row)
    new_row = []
    new_row.push(row[:id], row[:value], row[:currency], convert_value_to_euro(row[:currency], row[:value]))
    return new_row
  end

  # Contacts the API to convert the value into Euro
  # returns converted currency
  def convert_value_to_euro(current_currency, current_value)
    url = URI("https://api.apilayer.com/exchangerates_data/convert?to=EUR&from=#{current_currency}&amount=#{current_value}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["apikey"] = "ADD YOUR API KEY HERE"

    response = https.request(request)
    body = JSON.parse(response.read_body)

    return body["result"]
  end
end

exchange_function = ExchangeFunction.new()
exchange_function.convert_all()

require "dotenv"
require "net/http"
require "json"
Dotenv.load

class APIService
  # Contacts the API to convert the value into Euro
  # returns converted currency
  def convert_value_to_euro(current_currency, current_value)
    url = URI("https://api.apilayer.com/exchangerates_data/convert?to=EUR&from=#{current_currency}&amount=#{current_value}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["apikey"] =

      response = https.request(request)
    body = JSON.parse(response.read_body)

    if body["success"]
      return body["result"]
    else puts "failed at API call"     end
  end

  # Contacts API and returns a hashmap of conversion rates to euro
  def get_cenversion_rates_to_euro(currencies)
    currency_string = currencies.join("%2C")
    url = URI("https://api.apilayer.com/currency_data/live?source=eur&currencies=#{currency_string}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["apikey"] = ENV["API_KEY"]

    response = https.request(request)
    body = JSON.parse(response.read_body)
    if body["success"]
      return body["quotes"]
    else puts "failed at API call"     end
  end
end

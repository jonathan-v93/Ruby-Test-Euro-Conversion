require "csv"
require "uri"
require_relative "./api_service"

class ConvertService
  def initialize(csv_service)
    @csv_service = csv_service
    convert_all_csv()
  end

  # Gets file names of all csv files in the ./ToConvert directory and converts them into new format
  def convert_all_csv()
    Dir.entries("./ToConvert").each { |file_path|
      if file_path.include? ".csv"
        @csv_service.convert_csv_file("./ToConvert/" + file_path)
      end
    }
  end
end
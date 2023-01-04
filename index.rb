require_relative "./services/csv_service"
require_relative "./services/api_service"
require_relative "./services/convert_service"

api_service = APIService.new()
csv_service = CSVService.new(api_service)
convert_service = ConvertService.new(csv_service)
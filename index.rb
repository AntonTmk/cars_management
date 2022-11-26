require_relative 'search_class'
require_relative 'Car_Request'
request = Car_Request.new
result = Search_Class.new(request)
result.print

require_relative '../../2.1/Car_Request'
class Search_Class
  attr_accessor :request, :result

  def initialize(req)
    @request=req
    require 'yaml'
    car_array = YAML.load(File.read("cars.yml"))
    if(@request.sort_option!="date_added")
      if(@request.sort_direction=="asc")
        @result = car_array.sort_by{|v| -v["price"]}.find_all{|n| @request.car_eql(n)}
      else
        @result = car_array.sort_by{|v| v["price"]}.find_all{|n| @request.car_eql(n)}

      end
    else
      if(@request.sort_direction=="asc")
        @result=  car_array.sort_by{|v| m,d,y=v["date_added"].split("/");-[d,m,y]}.find_all{|n| @request.car_eql(n)}
      else
        @result = car_array.sort_by{|v| m,d,y=v["date_added"].split("/");[d,m,y]}.find_all{|n| @request.car_eql(n)}
      end
    end
  end
  def print
    puts @result.to_s.gsub(/[\"}\[]/, "").gsub(/[{\]]/, "\n--------------------------------------------\n").gsub(/,/, "\n").gsub(/=>/, ": ")
  end
end


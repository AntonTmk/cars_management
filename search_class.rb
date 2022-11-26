require_relative 'car_request'
class SearchClass
  attr_accessor :request, :result

  def initialize(req)
    @request=req
    require 'yaml'
    car_array = YAML.load(File.read("cars.yml"))
    if(@request.sort_option.casecmp("price")!=0)
      if(@request.sort_direction.casecmp("asc")==0)
        @result = car_array.sort_by{|v| d,m,y=v["date_added"].split("/");[y.to_i,m.to_i,d.to_i]}.find_all{|n| @request.car_eql?(n)}
      else
        @result=  car_array.sort_by{|v| d,m,y=v["date_added"].split("/");[y.to_i,m.to_i,d.to_i]}.find_all{|n| @request.car_eql?(n)}.reverse()
      end
    else
      if(@request.sort_direction.casecmp("asc")==0)
        @result = car_array.sort_by{|v| v["price"]}.find_all{|n| @request.car_eql(n)}
      else
        @result = car_array.sort_by{|v| -v["price"]}.find_all{|n| @request.car_eql(n)}
      end
    end
  end
  def print_result
    puts @result.to_s.gsub(/[\"}\[]/, "").gsub(/[{\]]/, "\n--------------------------------------------\n").gsub(/,/, "\n").gsub(/=>/, ": ")
  end
end


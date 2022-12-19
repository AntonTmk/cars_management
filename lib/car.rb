class Car
  attr_accessor :id, :make, :model, :year, :odometer, :description, :price, :date_added

  def params_menu
    id_validator
    @make = init_param("make: ")
    @model = init_param("model: ")
    @year = init_param("year: ")
    @odometer = init_param("odometer: ")
    @description = init_param("description: ")
    @price = init_param("price: ")
    @date_added = init_param("date_added: ")
  end

  def init_param(message)
    puts message
    gets.chomp
  end

  def to_hash
    {"id" => @id, "make" => @make, "model" => @model, "year" => @year, "odometer" => @odometer, "price"=> @price, "description" => @description, "date_added" => @date_added}
  end

  def id_validator
    while @id.to_s.length != 8
      @id = init_param("id:")
    end
    @id += '-330f-11ec-8d3d-0242ac130003'
  end
end
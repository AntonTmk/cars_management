class CarRequest
  attr_accessor :make, :model, :year_from, :year_to, :price_from, :price_to, :sort_option, :sort_direction

  def initialize
    puts "Please select search rules"
    puts "Please choose make:"
    @make=gets.chomp
    puts "Please choose model:"
    @model=gets.chomp
    puts "Please choose year_from:"
    @year_from=gets.chomp.to_i
    puts "Please choose year_to:"
    @year_to=gets.chomp.to_i
    puts "Please choose price_from:"
    @price_from=gets.chomp.to_i
    puts "Please choose price_to:"
    @price_to=gets.chomp.to_i
    puts "Please choose sort option (date_added|price):"
    @sort_option=gets.chomp
    puts "Please choose sort direction(desc|asc):"
    @sort_direction=gets.chomp
  end
  def get_Sort_Option
    return sort_option
  end
  def get_Sort_Direction
    return sort_direction
  end
  def car_eql(var)
    if(@make.empty? || var["make"].eql?("#{@make}") and @model.empty? || var["model"].eql?("#{@model}") and @year_from==0 || var["year"]>=@year_from  and @year_to==0 || var["year"]<=@year_to and @price_from==0 || var["price"]>=@price_from  and @price_to==0 || var["price"]<=@price_to)
      return true
    else
      return false
    end

  end
end


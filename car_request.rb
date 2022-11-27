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
  def car_eql?(var)
    text_check?(var) && num_check?(var)
  end
  def text_check?(var)
    text_eql?(@make, var["make"]) and text_eql?(@model, var["model"])
  end
  def num_check?(var)
    num_range?(@year_from, @year_to, var["year"]) and num_range?(@price_from, @price_to, var["price"])
  end
  def text_eql?(var1, var2)
    var1.empty? || var1.casecmp(var2)==0
  end
  def num_range?(min, max, var)
    min==0 || var>=min and max==0 || var<=max
  end
end


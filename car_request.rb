class CarRequest
  attr_accessor :make, :model, :year_from, :year_to, :price_from, :price_to, :sort_option, :sort_direction

  def initialize
    puts "Please select search rules"
    @make=set_data("Please choose make:")
    @model=set_data("Please choose model:")
    @year_from=set_data("Please choose year_from:").to_i
    @year_to=set_data("Please choose year_to:").to_i
    @price_from=set_data("Please choose price_from:").to_i
    @price_to=set_data("Please choose price_to:").to_i
    @sort_option=set_data("Please choose sort option (date_added|price):")
    @sort_direction=set_data("Please choose sort direction(desc|asc):")
  end
  def set_data(message)
    puts message
    gets.chomp
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


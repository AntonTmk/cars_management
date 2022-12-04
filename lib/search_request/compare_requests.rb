
require_relative '../../config/requirements'

module CompareRequests

  #eql
  def text_check?(var1, var2)
    text_eql?(var1.make, var2[:make].to_s) and text_eql?(var1.model, var2[:model])
  end

  def num_check?(var1, var2)
    num_eql?(var1.year_from, var2[:year_from]) and num_eql?(@year_to, var2[:year_to]) and
      num_eql?(var1.price_from, var2[:price_from]) and num_eql?(@price_to, var2[:price_to])
  end

  #include
  def text_check_nil?(var1, var2)
    text_include?(var1.make, var2['make']) || text_include?(var1.make, var2['make']) == nil and
      text_include?(var1.model, var2['model']) || text_include?(var1.model, var2['model']) == nil
  end

  def num_check_nil?(var1, var2)
    num_range?(var1.year_from, var1.year_to, var2['year']) || num_range?(var1.year_from, var1.year_to, var2['year']) == nil and
      num_range?(var1.price_from, var1.price_to, var2['price']) || num_range?(var1.price_from, var1.price_to, var2['price']) == nil
  end

  #eql
  def text_eql?(var1, var2)
    var1.to_s.casecmp(var2.to_s).zero?
  end

  def num_eql?(var1, var2)
    var1.to_i == var2.to_i
  end

  #include
  def text_include?(var1, var2)
    var1.empty? || var1.casecmp(var2.to_s).zero?
  end

  def num_range?(min, max, var)
    min.zero? || var >= min and max.zero? || var <= max
  end
end

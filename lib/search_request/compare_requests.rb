
require_relative '../../config/requirements'

module CompareRequests

  def text_check_nil?(var1, var2)
    text_include?(var1.make, var2['make']) and
      text_include?(var1.model, var2['model'])
  end

  def num_check_nil?(var1, var2)
    num_range?(var1.year_from, var1.year_to, var2['year']) and
      num_range?(var1.price_from, var1.price_to, var2['price'])
  end

  def text_include?(var1, var2)
    var1.empty? || var1.casecmp(var2.to_s).zero?
  end

  def num_range?(min, max, var)
    min.zero? || var >= min and max.zero? || var <= max
  end
end

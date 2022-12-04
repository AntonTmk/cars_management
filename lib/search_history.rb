
require_relative '../config/requirements'

module SearchHistory
  attr_accessor :request, :history
  DEFAULT_REQUESTS_QUANTITY = 1

  def result_quantity(request)
    @request = request
    @history = FileProcess.new('searches.yml')
    unless @history.file_content
      @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
      @history.file_content = [@request.car_hash(DEFAULT_REQUESTS_QUANTITY, @result.length)]
    else
      edit_history(@history.file_content)
    end
    @history.update_content
  end

  def edit_history(searches)
    if include_req?(searches)
      update_request(searches)
    else
      add_request(searches)
    end
  end

  def add_request(list)
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    list << @request.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)
  end

  def update_request(list)
    (0..list.length - 1).each do |v|
      if compare_req?(list[v])
        list[v][:requests_quantity] = list[v][:requests_quantity].to_i + 1
        list[v][:total_quantity] = @request.total_quantity.to_i
        @request.requests_quantity = list[v][:requests_quantity].to_i
      end
    end
  end

  def include_req?(searches)
    searches.select { |req| compare_req?(req) }.length > 0
  end

  def compare_req?(car)
    @request.car_eql?(car)
  end
end

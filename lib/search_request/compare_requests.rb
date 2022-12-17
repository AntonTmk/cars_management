# frozen_string_literal: true

require_relative '../../config/requirements'

# module for comparing search requests
module CompareRequests
  def text_eql_or_nil?(request_hash, hash)
    text_include?(request_hash.make, hash['make']) and
      text_include?(request_hash.model, hash['model'])
  end

  def num_eql_or_nil?(request_hash, hash)
    num_range?(request_hash.year_from, request_hash.year_to, hash['year']) and
      num_range?(request_hash.price_from, request_hash.price_to, hash['price'])
  end

  def text_include?(request_hash, hash)
    request_hash.empty? || request_hash.casecmp(hash.to_s).zero?
  end

  def num_range?(min, max, var)
    min.zero? || var >= min and max.zero? || var <= max
  end
end

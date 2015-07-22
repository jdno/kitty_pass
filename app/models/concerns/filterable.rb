# This module provides an easy way to search and filter models based on parameters. A full description of this
# approach and an explanation can be found here:
# http://www.justinweiss.com/blog/2014/02/17/search-and-filter-rails-models-without-bloating-your-controller/
module Filterable
  extend ActiveSupport::Concern

  # These class methods can be used once a class includes the Filterable module.
  module ClassMethods
    def filter(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end

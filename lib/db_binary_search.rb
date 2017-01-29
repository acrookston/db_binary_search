require "db_binary_search/version"
require 'active_record'

module DBBinarySearch
  extend ActiveSupport::Concern

  class_methods do
    def binary_search(column, value, lower_id=nil, upper_id=nil)
      lower_id = self.first.id unless lower_id
      upper_id = self.last.id unless upper_id

      if lower_id >= upper_id
        return upper_id
      else
        mid_id = lower_id + ((upper_id - lower_id) / 2.0).floor
        row = where(["`#{primary_key}` >= ?", mid_id]).limit(1).first

        return upper_id unless row

        column_value = row.send(column)

        if column_value > value
          return binary_search(column, value, lower_id, mid_id)
        elsif column_value < value
          return binary_search(column, value, mid_id + 1, upper_id)
        else
          return mid_id
        end
      end
    end
  end
end


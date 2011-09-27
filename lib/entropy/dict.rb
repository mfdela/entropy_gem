require 'bigdecimal'
require 'bigdecimal/util'


module Entropy
  class Dict

    def initialize
      @bucket = Hash.new(0)
      @space_size = 0
    end

    # Add an element to the space
    def upd(k)
      @bucket[k] += 1
      @space_size += 1
    end

    # Compute frequency of the element
    def freq(k)
      (@bucket[k].to_d / @space_size)
    end

    # Return all the elements of the space
    def scan_keys
      @bucket.keys
    end

  end
end

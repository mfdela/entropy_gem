require "entropy/version"
require "entropy/stream"
require "entropy/dict"
require "entropy/probability_space.rb"
require "entropy/metric_space.rb"

module Entropy

  def self.version_string
    "Entropy version #{Entropy::VERSION}"
  end

end

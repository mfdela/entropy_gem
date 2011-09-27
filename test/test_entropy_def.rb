require 'test/unit'
require 'entropy'

class TestEntropy < Test::Unit::TestCase

  def test_version_string
    assert_equal Entropy.version_string, "Entropy version #{Entropy::VERSION}"
  end
end


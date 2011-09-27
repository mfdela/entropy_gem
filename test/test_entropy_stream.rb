require 'test/unit'
require 'entropy'

class TestEntropy < Test::Unit::TestCase

  def test_char_file
    assert_nothing_raised do
      file = File.open("test/stream1.txt", "r")
      obj = Entropy::Stream.new
      obj.add_stream(file)
    end
  end
  def test_string
    assert_nothing_raised do
      obj = Entropy::Stream.new
      obj.add_stream("000000000")
    end
  end

  def test_string_and_file
    assert_nothing_raised do
      obj = Entropy::Stream.new
      obj.add_stream("000000000")
      file = File.open("test/stream1.txt", "r")
      obj.add_stream(file)
    end
  end
end


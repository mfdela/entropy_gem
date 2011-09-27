require 'test/unit'
require 'entropy'

class TestEntropy < Test::Unit::TestCase

  def test_string_prob
    obj = Entropy::ProbabilitySpace.new
    obj.add_stream("000000000")
    assert_equal obj.prob_space, [1.0]
  end
  
  def test_string_prob_2
    obj = Entropy::ProbabilitySpace.new
    obj.add_stream("1000")
    assert_equal obj.prob_space.sort, [0.25, 0.75]
  end

  def test_cardinality 
    obj = Entropy::ProbabilitySpace.new
    stream = "11111111"
    obj.add_stream(stream)
    assert_equal obj.cardinality(2).round, 1
  end
  
  def test_cardinality_2
    obj = Entropy::ProbabilitySpace.new
    stream = "1234"
    obj.add_stream(stream)
    assert_equal obj.cardinality(2).round, stream.size
  end

  def test_diversity
    obj = Entropy::ProbabilitySpace.new
    stream = "11111111"
    obj.add_stream(stream)
    assert_equal obj.diversity(2).round, 0
    assert_equal obj.renyi_entropy(:infinite).round, 0
  end
  
  def test_diversity_2
    obj = Entropy::ProbabilitySpace.new
    stream = "1234"
    obj.add_stream(stream)
    assert_equal obj.diversity(2), obj.surprise(2, 1.0/stream.size)
    assert_equal obj.renyi_entropy(:infinite), -Math.log(0.25)
  end
  
  def test_entropy_renyi
    obj = Entropy::ProbabilitySpace.new
    stream = "11111111"
    obj.add_stream(stream)
    assert_equal obj.renyi_entropy(2), 0
  end

  def test_entropy_renyi_2
    obj = Entropy::ProbabilitySpace.new
    stream = "1234"
    obj.add_stream(stream)
    p = 0.25*0.25
    assert_equal obj.renyi_entropy(2), -Math.log(4*p)
    assert_equal obj.renyi_entropy(:infinite), -Math.log(0.25)
  end
end


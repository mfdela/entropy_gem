require 'test/unit'
require 'entropy'

class TestEntropy < Test::Unit::TestCase

  def test_string_metr
    obj = Entropy::ProbabilityMetricSpace.new
    obj.add_stream("000000000")
    obj.define_distance {|i, j| Math.sqrt(i*i + j*j) }
    assert_equal obj.prob_space, [1.0]
  end
  
  def test_string_metr_2
    obj = Entropy::ProbabilityMetricSpace.new
    obj.add_stream("1000")
    obj.define_distance {|i, j| Math.sqrt(i*i + j*j) }
    assert_equal obj.prob_space.sort, [0.25, 0.75]
  end

  def test_distance_metr
    obj = Entropy::ProbabilityMetricSpace.new
    obj.add_stream("0123")
    obj.define_distance {|i, j| Math.sqrt(i*i + j*j) }
    m = Matrix.build(4, 4) {|i, j| Math.sqrt(i*i + j*j) }
    assert_equal obj.distance_matrix, m
  end

  def test_entropy_metr
    obj = Entropy::ProbabilityMetricSpace.new
    obj.add_stream("0123")
    obj.define_distance {|i, j| 1 }
    assert_equal obj.diversity(1), 1
  end

end


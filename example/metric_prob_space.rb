require 'entropy'
require 'pp'

# note: require ruby 1.9.x

obj = Entropy::ProbabilityMetricSpace.new
obj.add_stream("000000000")
obj.define_distance {|i, j| Math.sqrt(i*i + j*j) }
pp obj.prob_space # [1.0]

obj = Entropy::ProbabilityMetricSpace.new
obj.add_stream("0123")
obj.define_distance {|i, j| Math.sqrt(i*i + j*j) }
m = Matrix.build(4, 4) {|i, j| Math.sqrt(i*i + j*j) }
pp obj.distance_matrix  # = m
pp m

# redefine prob_space
#
puts "redefine prob_space and distance matrix"
obj.prob_space = [0.25, 0.75]
distance = Matrix[[2, 2], [4, 4]]
obj.define_distance(distance)
pp obj.prob_space # [0.25, 0.25, 0.25, 0.25]
pp distance
puts obj.cardinality(2) 
puts obj.diversity(2) 
puts obj.renyi_entropy(2) 
puts obj.renyi_entropy(0) 
puts obj.renyi_entropy(:infinite) 

# setting infinite distance means having a discrete set
puts "setting infinite distance means having a discrete set"
distance = Matrix[[:infinite, :infinite], [:infinite, :infinite]]
obj.define_distance(distance)
pp obj.prob_space # [0.25, 0.25, 0.25, 0.25]
pp distance
puts obj.cardinality(2) 
puts obj.diversity(2) 
puts obj.renyi_entropy(2) 
puts obj.renyi_entropy(0) 
puts obj.renyi_entropy(:infinite) 



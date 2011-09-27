require 'entropy'
require 'pp'

# note: require ruby 1.9.x

obj = Entropy::ProbabilitySpace.new
obj.add_stream("000000000")
pp obj.prob_space   # [1.0]
puts obj.cardinality(2) # 1 equal to shannon entropy
puts obj.diversity(2).round # 0
puts obj.renyi_entropy(2).round # 0
puts obj.renyi_entropy(:infinite).round # 0
  
obj = Entropy::ProbabilitySpace.new
obj.add_stream("1234")
pp obj.prob_space # [0.25, 0.25, 0.25, 0.25]
puts obj.cardinality(2) # 4 equal to shannon entropy
puts obj.diversity(2) # 3/4
puts obj.renyi_entropy(2) # 2 
puts obj.renyi_entropy(:infinite) 

# redefine prob_space
puts "redefine prob_space"
obj.prob_space = [0.25, 0.75]
pp obj.prob_space # [0.25, 0.25, 0.25, 0.25]
puts obj.cardinality(2) # 1.6
puts obj.diversity(2) # 0.375
puts obj.renyi_entropy(2) 
puts obj.renyi_entropy(0) 
puts obj.renyi_entropy(:infinite) 




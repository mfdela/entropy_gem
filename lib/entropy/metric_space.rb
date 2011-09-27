require "matrix"

module Entropy

  # Entropy::ProbabilityMetricSpace defines a finite probability metric space
  class ProbabilityMetricSpace < ProbabilitySpace

    attr_reader :distance_matrix, :distance_function

    def initialize
      @distance_matrix = nil
      @density = nil
      super
    end

    # Adds a set of elements (char, bit) to the space
    def add_stream(stream)
      super(stream)
    end

    # Defines the distance among the elements of the set.
    # The method accepts a block, so you can use your
    # function to calculate the distance. The function should
    # accept two parameters, viz. the ordinals i,j of the elements
    # and should return a decimal number, the distance between 
    # element i and j.
    # In alternative you could pass a matrix of numbers defining
    # the distances among i's and j's.
    def define_distance(*args, &blk)
      if !blk.nil?
        @distance_function = blk
        update_distance_matrix
      else
        mat = args[0]
        raise "distance matrix is not a matrix object" if !mat.respond_to?("square?") 
        raise "distance matrix is not square" if !mat.square?
        raise "distance matrix has wrong dimensions" if mat.to_a.size != @prob_space.size
        @distance_matrix = mat
      end
      z = @distance_matrix.map { |d| d == :infinite ? 0 : Math.exp(-d) }
      @density = z * Matrix.column_vector(@prob_space)
      @density = @density.column(0).to_a
    end

    # Computes the Shannon Entropy of the space
    def shannon_entropy
      diversity(1)
    end

    # Computes the Rao Entropy of the space
    def rao_entropy
      diversity(2)
    end


    # Computes the Renyi Entropy (α-Entropy) of the space
    def renyi_entropy(alpha)
      raise "Warning: distance metric not defined..." if @distance_matrix.nil?
      h = 0
        if alpha == 1
          @prob_space.each_index do |i| 
            h += -@prob_space[i] * Math.log(@density[i])
          end
        elsif alpha == :infinite
          h = -Math.log(@density.max)
        else
          @prob_space.each_index do |i| 
            h += @prob_space[i] * (@density[i]**(alpha - 1))
          end
          h = 1.0 / (1 - alpha) * Math.log(h)
        end
      h
    end

    # Computes the α-Diversity of the space
    def diversity(alpha)
      raise "Warning: distance metric not defined..." if @distance_matrix.nil?
      div = []
      @prob_space.each_index do |i| 
        p = @prob_space[i]
        div[i] = p *  surprise(alpha, @density[i])
      end
      div.inject(:+)
    end
    
    # Computes the α-Cardinality of the space
    def cardinality(alpha)
      raise "Warning: distance metric not defined..." if @distance_matrix.nil?
      card = 0
      if alpha == 1
        card = 1
        @prob_space.each_index do |i| 
          card = card * (@density[i] ** (-@prob_space[i]))
        end
      elsif alpha == :infinite
        card = 1.0/@density.max
      else
        @prob_space.each_index do |i| 
          card += @prob_space[i] * (@density[i]**(alpha - 1))
        end
        card = card ** (1.0 / (1 - alpha)) if card != 0
      end
      card
    end

    private
    def update_distance_matrix
      if !@distance_function.nil?
        puts "Applying function #{@distance_function.to_s} to the probability space..."
        @distance_matrix = Matrix.build (@prob_space.size) { |i, j| @distance_function.call(i, j) }
      end
    end

  end

end

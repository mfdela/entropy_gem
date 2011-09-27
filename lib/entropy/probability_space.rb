module Entropy

  # Entropy::ProbabilitySpace defines a finite probability space
  class ProbabilitySpace

    attr_accessor :prob_space

    def initialize
      @space = Entropy::Stream.new
      @dict = Entropy::Dict.new()
      @prob_space = []
    end

    # Adds a set of elements (char, bit) to the space
    def add_stream(stream)
      puts "Adding a set in the probability space..."
      @space.add_stream(stream)
      update_probability_space(stream)
    end

    # Computes the Shannon Entropy of the space
    def shannon_entropy
      diversity(1)
    end

    # Computes the Renyi Entropy (α-Entropy) of the space
    def renyi_entropy(alpha)
      h = 0
        if alpha == 1
          h = @prob_space.map {|p| -p * Math.log(p)}.inject(:+)
        elsif alpha == :infinite
          h = -Math.log(@prob_space.max)
        else
          h =  @prob_space.map {|p| p**alpha}.inject(:+)
          h = 1.0 / (1 - alpha) * Math.log(h)
        end
      h
    end

    # Computes the α-Diversity of the space
    def diversity(alpha)
      @prob_space.map {|p| p * surprise(alpha, p) }.inject(:+)
    end
    
    # Surprise function
    def surprise(alpha, p)
      s = 0
      if alpha == 1
        s = -Math.log(p)
      elsif alpha == :infinite
        s = 0
      else
        e = alpha - 1
        s = 1.0 / e * (1 - p**e)
      end
      s
    end

    # Computes the α-Cardinality of the space
    def cardinality(alpha)
      card = 0
      if alpha == 1
        card = @prob_space.map {|p| p**(-p)}.inject(1, :*)
      elsif alpha == :infinite
        card = 1.0/@prob_space.max
      else
        card = @prob_space.map {|p| p**alpha}.inject(:+)
        card = card ** (1.0 / (1 - alpha))
      end
      card
    end

    private
    def update_probability_space(stream)
      @prob_space = []
      it = @space.streams[stream]
      stream.send(it).each do |b|
        c = b
        if it == :each_char
            c.chomp!
            next if c.empty?
        end
        @dict.upd(c)
      end
      @dict.scan_keys.each do |k|
        @prob_space << @dict.freq(k)
      end
    end
  end

end

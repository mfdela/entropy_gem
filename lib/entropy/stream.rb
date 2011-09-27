module Entropy

  # Class used to define a stream inside the space
  class Stream

    attr_reader :streams

    def initialize
      @streams = Hash.new
    end

    # Adds a stream (a File or a String) to the space
    def add_stream(stream)
      iter = nil 
      if stream.respond_to?("binmode?")
        if stream.binmode?
          puts "Binary File Stream Initialization..."
          iter = :each_byte
        else
          puts "Char File Stream Initialization..."
          iter = :each_char
        end
      elsif  stream.respond_to?("each_char")
        puts "Char Stream Initialization..."
        iter = :each_char
      elsif  stream.respond_to?("each_byte")
        puts "Binary Stream Initialization..."
        iter = :each_byte
      else
        raise "Wrong type of stream"
      end
      @streams[stream] = iter
    end

  end

end

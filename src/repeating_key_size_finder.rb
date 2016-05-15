require_relative 'hamming_distance_calculator'
require_relative 'byte_converter'

class RepeatingKeySizeFinder
  class << self
    def with_hex hex
      bytes = ByteConverter.convert_to_bytes hex
      new bytes
    end

    private :new
  end

  def initialize cypher_bytes
    @key_size = most_likely_key_size cypher_bytes
  end

  attr_reader :key_size

  private
  def most_likely_key_size cypher_bytes
    possible_key_sizes = (2..40)
    number_of_blocks_to_average_over = 4

    normalized_hamming_distances = possible_key_sizes.map do |key_size|
      if not_enough_cypher_bytes_to_average_over cypher_bytes, key_size, number_of_blocks_to_average_over
        next [cypher_bytes.length, key_size]
      end

      #puts "cypher_bytes: #{cypher_bytes}"
      #puts "key_size: #{key_size}"
      key_size_blocks = (0..number_of_blocks_to_average_over-1).map { |x| cypher_bytes[key_size*x, key_size] }
      #puts "key_size_blocks: #{key_size_blocks}"

      normalized_distances = key_size_blocks.combination(2).to_a.map do |block1,block2|
        hamming_distance = HammingDistanceCalculator.new(block1, block2).distance
        hamming_distance.to_f / key_size.to_f
      end
      #puts "normalized_distances: #{normalized_distances}"

      sum = normalized_distances.reduce(0.0) { |sum, x| sum + x }
      average_hamming_distance = sum / normalized_distances.length.to_f
      [average_hamming_distance, key_size]
    end

    #puts "hamming distances: #{normalized_hamming_distances}"

    result = normalized_hamming_distances.min_by { |x| x[0] }
    result[1]
  end

  def not_enough_cypher_bytes_to_average_over cypher_bytes, key_size, number_of_blocks_to_average_over
    cypher_bytes.length < key_size*number_of_blocks_to_average_over
  end
end

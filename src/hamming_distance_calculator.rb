class HammingDistanceCalculator
  def initialize(string1, string2)
    @distance = hamming_distance string1.bytes, string2.bytes
  end

  attr_reader :distance

  private
  def hamming_distance bytes1, bytes2
    unless bytes1.length == bytes2.length
      raise ArgumentError, "Need same number of bytes to compare to calculate the Hamming Distance"
    end

    bytes1.zip(bytes2).reduce(0) do |hamming_distance, current_pair|
      x, y  = current_pair
      number_of_identical_bits = (x^y).to_s(2).count('1')
      hamming_distance + number_of_identical_bits
    end
  end
end

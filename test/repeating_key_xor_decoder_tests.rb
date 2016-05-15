require 'minitest/autorun'
require_relative '../src/hamming_distance_calculator.rb'
require_relative '../src/repeating_key_xor_encoder.rb'
require_relative '../src/repeating_key_size_finder.rb'
require_relative '../src/repeating_key_xor_decoder.rb'

class RepeatingKeyXorDecoderTests < MiniTest::Test
  def test_hamming_distance_calculation
    calculator = HammingDistanceCalculator.with_strings 'this is a test', 'wokka wokka!!!'
    assert_equal 37, calculator.distance
  end

  def test_key_size_finder
    plain_text = 'My secret plain text. That needs to be a bit longer so that more key sizes can be used'
    cypher_text = RepeatingKeyXorEncoder.new('IsLonger', plain_text).cypher_text
    finder = RepeatingKeySizeFinder.with_hex(cypher_text)
    assert_equal 8, finder.key_size
  end

  def test_key_size_finder
    plain_text = 'My secret plain text. That needs to be a bit longer so that more key sizes can b'
    cypher_text = RepeatingKeyXorEncoder.new('IsLonger', plain_text).cypher_text
    decoder = RepeatingKeyXorDecoder.new(cypher_text)
    assert_equal 'IsLonger', decoder.key
    assert_equal plain_text, decoder.plain_text
  end
end

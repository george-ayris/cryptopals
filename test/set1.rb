require "minitest/autorun"
require_relative "../src/set1.rb"

class Set1Tests < MiniTest::Test
  def setup
    @input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
  end

  def test_challenge_1
    assert_equal "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t",
                 hex_to_base64(@input)
  end

  def test_fixed_xor
    assert_equal "74", fixed_xor("1c", "68")
  end

  def test_challenge_2
    assert_equal "746865206b696420646f6e277420706c6179",
                 fixed_xor("1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965")
  end

  def test_letter_frequencies
    frequency_hash = calculate_letter_frequencies("Aaaahhh, letters")
    assert_equal 4, frequency_hash['a']
    assert_equal 3, frequency_hash['h']
    assert_equal 1, frequency_hash['l']
    assert_equal 2, frequency_hash['e']
    assert_equal 2, frequency_hash['t']
    assert_equal 1, frequency_hash['r']
    assert_equal 1, frequency_hash['s']
  end

  def test_calculate_frequency_score
    frequency_hash = calculate_letter_frequencies("etaoin etaoin vkjxqz")
    assert_equal 12, calculate_english_frequency_score(frequency_hash)
  end

  def test_single_byte_xor_cypher
    decoded_text, key = single_byte_xor_cypher("f29bdad69be8cbdac9cfdad8cec8")
    assert_equal "I am Spartacus", decoded_text
    assert_equal 'b', key
  end
end

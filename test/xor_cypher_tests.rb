require "minitest/autorun"
require_relative "../src/bytes.rb"
require_relative "../src/english_score_calculator.rb"
require_relative "../src/single_byte_xor_cypher_decoder.rb"

class XorCypherTests < MiniTest::Test
  def test_hex_to_base64
    b = Bytes.new("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
    assert_equal "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t", b.base64_representation()
  end

  def test_xor_with_hex_byte
    b = Bytes.new("1c")
    after_xor = b.xor_with_byte("68")
    assert_equal "74", after_xor.hex_representation()
  end

  def test_with_numeric_byte
    b = Bytes.new("1c")
    after_xor = b.xor_with_byte(104)
    assert_equal "74", after_xor.hex_representation()
  end

  def test_xor_with_string
    b = Bytes.new("1c0111001f010100061a024b53535009181c")
    after_xor = b.xor_with_string("686974207468652062756c6c277320657965")
    assert_equal "746865206b696420646f6e277420706c6179", after_xor.hex_representation()
  end

  def test_english_score_calculator
    calc1 = EnglishScoreCalculator.new("This is a fairly normal, but somewhat short english sentence.")
    calc2 = EnglishScoreCalculator.new("yyasinxazz jj queekd qqz")
    assert calc1.is_more_likely_to_be_english_than(calc2)
  end

  def test_single_byte_xor_cypher_decoder
    decoder = SingleByteXorCypherDecoder.new(Bytes.new("523b7a763b486b7a696f7a786e68"))
    assert_equal "I am Spartacus", decoder.clear_text()
    assert_equal 27, decoder.key()
  end
end

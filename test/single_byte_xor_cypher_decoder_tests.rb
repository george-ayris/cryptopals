require "minitest/autorun"
require_relative "../src/bytes.rb"
require_relative "../src/english_score_calculator.rb"
require_relative "../src/single_byte_xor_cypher_decoder.rb"

class SingleByteXorCypherDecoderTests < MiniTest::Test
  def test_english_score_calculator
    calc1 = EnglishScoreCalculator.new("This is a fairly normal, but somewhat short english sentence.")
    calc2 = EnglishScoreCalculator.new("yyasinxazz jj queekd qqz")
    assert calc1.is_more_likely_to_be_english_than(calc2)
  end

  def test_devalue_random_punctuation
    calc1 = EnglishScoreCalculator.new("Now that the party is jumping\n")
    calc2 = EnglishScoreCalculator.new("I/ESt0@,oITDM2#/}r88@I(Wrspl\\")
    assert calc1.is_more_likely_to_be_english_than(calc2)
  end

  def test_single_byte_xor_cypher_decoder
    decoder = SingleByteXorCypherDecoder.new(Bytes.new("523b7a763b486b7a696f7a786e68"))
    assert_equal "I am Spartacus", decoder.clear_text()
    assert_equal 27, decoder.key()
  end

  def test_prefer_strings_with_valid_punctuation
    decoder = SingleByteXorCypherDecoder.new(Bytes.new("7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f"))
    assert_equal "Now that the party is jumping\n", decoder.clear_text()
  end
end

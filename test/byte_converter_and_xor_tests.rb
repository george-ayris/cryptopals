require 'minitest/autorun'
require_relative '../src/byte_converter.rb'
require_relative '../src/xor.rb'

class ByteConverterAndXorTests < MiniTest::Test
  def test_hex_to_base64
    base64 = ByteConverter.convert_to_base64 "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    assert_equal "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t", base64
  end

  def test_xor_with_hex_byte
    xor = Xor.hex_strings "1c", "68"
    assert_equal "74", xor.hex_result
  end

  def test_with_numeric_byte
    xor = Xor.bytes 104, 28
    assert_equal "74", xor.hex_result
  end

  def test_xor_with_string
    xor = Xor.hex_strings "1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965"
    assert_equal "746865206b696420646f6e277420706c6179", xor.hex_result
  end

  def test_empty_byte_array
    assert_equal "", ByteConverter.convert_to_hex([])
  end
end

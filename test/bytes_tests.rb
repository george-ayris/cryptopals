require 'minitest/autorun'
require_relative '../src/bytes.rb'

class BytesTests < MiniTest::Test
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

  def test_byte_array_constructor
    b = Bytes.new([28])
    after_xor = b.xor_with_byte("68")
    assert_equal "74", after_xor.hex_representation()
  end

  def test_empty_byte_array
    b = Bytes.new([])
    assert_equal "", b.hex_representation()
  end
end

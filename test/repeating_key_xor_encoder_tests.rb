require 'minitest/autorun'
require_relative '../src/repeating_key_xor_encoder.rb'

class RepeatingKeyXorEncoderTests < MiniTest::Test
  def test_encode_with_repeating_key
    plain_text = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    encoder = RepeatingKeyXorEncoder.new('ICE', plain_text)
    assert_equal "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f",
      encoder.cypher_text()
  end
end

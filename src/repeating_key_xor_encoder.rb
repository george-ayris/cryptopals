require_relative 'bytes.rb'

class RepeatingKeyXorEncoder
  def initialize(key, plain_text)
    key = Bytes.new(key.bytes)
    plain_text = Bytes.new(plain_text.bytes)

    @cypher_text = repeating_key_encode(key, plain_text)
  end

  def cypher_text
    @cypher_text.hex_representation()
  end

  private
  def repeating_key_encode(key, plain_text)
    cypher_text = Bytes.new([])
    number_of_bytes = plain_text.number_of_bytes()
    key_length = key.number_of_bytes()

    (0..(number_of_bytes-1)).each do |i|
      key_byte = key.byte_n(i % key_length)
      plain_text_byte = plain_text.byte_n(i)
      encoded_byte = plain_text_byte.xor_with_byte(key_byte)
      cypher_text = cypher_text.concat(encoded_byte)
    end

    cypher_text
  end
end

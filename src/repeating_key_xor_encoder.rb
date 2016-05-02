require_relative 'xor.rb'
require_relative 'byte_converter.rb'

class RepeatingKeyXorEncoder
  def initialize key, plain_text
    @cypher_bytes = repeating_key_encode key.bytes, plain_text.bytes
  end

  def cypher_text
    ByteConverter.convert_to_hex @cypher_bytes
  end

  private
  def repeating_key_encode key, plain_text
    cypher_bytes = []

    plain_text.each_with_index do |plain_text_byte, index|
      key_byte = key[index % key.length]
      encoded_byte = Xor.bytes(plain_text_byte, key_byte).bytes_result
      cypher_bytes.concat encoded_byte
    end

    cypher_bytes
  end
end

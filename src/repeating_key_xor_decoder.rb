require_relative 'repeating_key_size_finder'
require_relative 'byte_converter'
require_relative 'single_byte_xor_cypher_decoder'

class RepeatingKeyXorDecoder
  def initialize cypher_text
    @key, @plain_text = decode cypher_text
  end

  attr_reader :key, :plain_text

  private
  def decode cypher_text
    key_size = RepeatingKeySizeFinder.with_hex(cypher_text).key_size
    cypher_bytes = ByteConverter.convert_to_bytes cypher_text

    number_of_blocks = cypher_bytes.length / key_size
    blocks_of_key_size = (0..number_of_blocks-1).map { |n| cypher_bytes[key_size*n, key_size] }
    bytes_per_key_element = blocks_of_key_size.transpose

    decoders = bytes_per_key_element.map { |x| SingleByteXorCypherDecoder.with_bytes x }

    key = decoders.map { |d| d.key.chr }.join
    plain_text = decoders.map { |d| d.clear_text.split(//) }.transpose.flatten.join

    [key, plain_text]
  end
end

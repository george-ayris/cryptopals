require_relative '../src/single_byte_xor_cypher_decoder.rb'
require_relative '../src/bytes.rb'

decoder = SingleByteXorCypherDecoder.new(Bytes.new("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"))
puts "Results"
puts "clear text: #{decoder.clear_text()}"
puts "key: #{decoder.key()}"

require_relative '../src/single_byte_xor_cypher_decoder'
require_relative '../src/byte_converter'
require_relative '../src/byte_converter'
require_relative '../src/repeating_key_xor_decoder'
require 'OpenSSL'

# Challenges 1 and 2 are covered in bytes_tests.rb

# Challenge 3
decoder = SingleByteXorCypherDecoder.with_hex("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
puts "Challenge 3 results"
puts "clear text: #{decoder.clear_text()}"

# Challenge 4
clear_text = ""
score = 0
File.readlines(File.join(File.dirname(__FILE__), '../data/set1challenge4.txt')).each do |line|
  decoder = SingleByteXorCypherDecoder.with_hex(line)
  if decoder.score > score
    score = decoder.score
    clear_text = decoder.clear_text
  end
end
puts "Challenge 4 results"
puts "clear text: #{clear_text}"

# Challenge 5 is covered in repeating_key_xor_encoder_tests.rb

# Challenge 6
File.open(File.join(File.dirname(__FILE__), '../data/set1challenge6.txt')) do |f|
  base64_string = f.read
  hex_string = ByteConverter.convert_to_hex(ByteConverter.convert_from_base64(base64_string))
  decoder = RepeatingKeyXorDecoder.new(hex_string)
  puts "Challenge 6 results"
  puts "clear_text #{decoder.plain_text}"
end

# Challenge 7
File.open(File.join(File.dirname(__FILE__), '../data/set1challenge7.txt')) do |f|
  base64_string = f.read
  bytes = ByteConverter.convert_from_base64(base64_string).map { |x| x.chr }.join
  cipher = OpenSSL::Cipher.new 'AES-128-ECB'
  cipher.decrypt
  cipher.key = 'YELLOW SUBMARINE'

  puts "Challenge 7 results"
  puts "clear_text #{cipher.update(bytes) + cipher.final}"
end

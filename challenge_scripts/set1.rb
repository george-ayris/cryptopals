require_relative '../src/single_byte_xor_cypher_decoder.rb'
require_relative '../src/bytes.rb'

# CHallenges 1 and 2 are covered in tests

# Challenge 3
decoder = SingleByteXorCypherDecoder.new(Bytes.new("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"))
puts "Challenge 3 results"
puts "clear text: #{decoder.clear_text()}"


# Challenge 4
clear_text = ""
score = 1000
File.readlines(File.join(File.dirname(__FILE__), '../data/set1challenge4.txt')).each do |line|
  decoder = SingleByteXorCypherDecoder.new(Bytes.new(line))
  if decoder.score() < score
    score = decoder.score()
    clear_text = decoder.clear_text()
  end
end
puts "Challenge 4 results"
puts "clear text: #{clear_text}"

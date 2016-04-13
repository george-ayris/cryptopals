require 'base64'

def hex_to_base64(input_string)
  binary = input_string.scan(/../).map { |x| x.hex.chr }.join
  Base64.strict_encode64(binary)
end

input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
puts hex_to_base64(input)

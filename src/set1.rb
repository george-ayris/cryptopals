require 'base64'

def hex_to_binary(input_string)
  input_string.scan(/../).map { |x| x.hex.chr }.join
end

def hex_to_base64(input_string)
  Base64.strict_encode64(hex_to_binary(input_string))
end

def fixed_xor(hex_string_1, hex_string_2)
  nil
end

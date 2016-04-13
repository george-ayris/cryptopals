require 'base64'

def hex_to_binary(input_string)
  input_string.scan(/../).map { |x| x.hex }
end

def binary_to_hex(binary)
  b = binary.to_s(16)
  if b.length == 1
    b = "0" + b
  end
  b
end

def hex_to_base64(input_string)
  binary = hex_to_binary(input_string)
  Base64.strict_encode64(binary.map { |x| x.chr }.join)
end

def fixed_xor(hex_string_1, hex_string_2)
  binary_1 = hex_to_binary(hex_string_1)
  binary_2 = hex_to_binary(hex_string_2)
  binary_1.zip(binary_2).map {|x,y| binary_to_hex(x^y) }.join
end

require 'base64'

module ByteConverter
  extend self

  def convert_to_base64 hex_representation
    byte_array = convert_to_bytes hex_representation
    Base64.strict_encode64(byte_array.map { |x| x.chr }.join)
  end

  def convert_to_bytes hex_representation
    hex_representation.scan(/../).map { |x| x.hex }
  end

  def convert_to_hex byte_array
    hex_array = byte_array.map do |b|
      hex = b.to_s 16
      hex = "0" + hex if hex.length == 1
      hex
    end
    hex_array.join
  end
end

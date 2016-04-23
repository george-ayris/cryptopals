require 'base64'

class Bytes
  def initialize(hex_representation)
    @hex_representation = hex_representation
    @byte_array = hex_to_byte_array(hex_representation)
  end

  def hex_representation()
    @hex_representation
  end

  def base64_representation()
    Base64.strict_encode64(@byte_array.map { |x| x.chr }.join)
  end

  def character_representation()
    @byte_array.map { |x| x.chr }.join
  end

  def xor_with_byte(byte)
    if byte.is_a? String
      raise ArgumentError, "Must be a 2 character hex string" unless byte.length == 2
      byte = byte.hex
    end

    xor = @byte_array.map { |x| x^byte }
    self.class.new(byte_array_to_hex(xor))
  end

  def xor_with_string(hex_string)
    unless hex_string.is_a? String and hex_string.length == @hex_representation.length
      raise ArgumentError, "Must be a hex string of same length as this one"
    end

    as_bytes = hex_to_byte_array(hex_string)
    xor = as_bytes.zip(@byte_array).map { |x,y| x^y }
    self.class.new(byte_array_to_hex(xor))
  end

  private
  def hex_to_byte_array(hex_representation)
    hex_representation.scan(/../).map { |x| x.hex }
  end

  def byte_array_to_hex(byte_array)
    hex_array = byte_array.map do |b|
      hex = b.to_s(16)
      if hex.length == 1
        hex = "0" + hex
      end
      hex
    end
    hex_array.join
  end
end

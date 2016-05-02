require_relative 'byte_converter.rb'

class Xor
  class << self
    def hex_strings hex_string1, hex_string2
      new ByteConverter.convert_to_bytes(hex_string1),
          ByteConverter.convert_to_bytes(hex_string2)
    end

    def bytes bytes1, bytes2
      bytes1 = [bytes1] if bytes1.is_a? Fixnum
      bytes2 = [bytes2] if bytes2.is_a? Fixnum
      
      new bytes1, bytes2
    end

    def array_with_single_byte byte_array, byte
      if byte.is_a? String
        raise ArgumentError, "Must be a 2 character hex string" unless byte.length == 2
        byte = byte.hex
      end

      new byte_array, [byte]*byte_array.length
    end

    private :new
  end

  def initialize bytes1, bytes2
    raise ArgumentError, "Must be same number of bytes" unless bytes1.length == bytes2.length
    @result = xor_bytes bytes1, bytes2
  end

  def bytes_result
    @result
  end

  def hex_result
    ByteConverter.convert_to_hex @result
  end

  def character_result
    @result.map { |x| x.chr }.join
  end

  private
  def xor_bytes bytes1, bytes2
    bytes1.zip(bytes2).map { |x,y| x^y }
  end
end

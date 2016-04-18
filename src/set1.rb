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

def xor_against_single_character(hex_string, character)
  fixed_xor(hex_string, character*hex_string.length)
end

def calculate_letter_frequencies(input_string)
  def letter?(character)
    character =~ /[[:alpha:]]/
  end

  frequency = Hash.new(0)
  input_string.split("").each do |x|
    x.downcase!
    if letter?(x)
      frequency[x] += 1
    end
  end

  frequency
end

def calculate_english_frequency_score(frequency_hash)
  def most_frequent(hash)
    frequency = 0
    letter = nil
    hash.each { |key, value|
      if value > frequency
        letter = key
        frequency = value
      end
    }
    [letter, frequency]
  end

  def least_frequent(hash)
    frequency = nil
    letter = nil
    hash.each { |key, value|
      if frequency.nil? or value < frequency
        letter = key
        frequency = value
      end
    }
    [letter, frequency]
  end

  most_frequent_english_letters = "etaoin"
  least_frequent_english_letters = "vkjxqz"

  least_frequent_letters = Hash.new
  most_frequent_letters = Hash.new
  frequency_hash.each do |key, value|
    if least_frequent_letters.size < 6
      least_frequent_letters[key] = value
    else
      letter, frequency = most_frequent(least_frequent_letters)
      if value < frequency
        least_frequent_letters.delete(letter)
        least_frequent_letters[key] = value
      end
    end

    if most_frequent_letters.size < 6
      most_frequent_letters[key] = value
    else
      letter, frequency = least_frequent(most_frequent_letters)
      if value > frequency
        most_frequent_letters.delete(letter)
        most_frequent_letters[key] = value
      end
    end
  end

  frequency_score = 0
  most_frequent_english_letters.split("").each do |x|
    if most_frequent_letters.key?(x)
      frequency_score += 1
    end
  end

  least_frequent_english_letters.split("").each do |x|
    if least_frequent_letters.key?(x)
      frequency_score += 1
    end
  end

  frequency_score
end

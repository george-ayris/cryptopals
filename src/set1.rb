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

def xor_against_single_byte(hex_string, hex_byte)
  fixed_xor(hex_string, hex_byte*(hex_string.length/2))
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

def normalise_frequency_hash(frequency_hash)
  normalising_factor = frequency_hash.values.reduce(:+)
  h = Hash[frequency_hash.map { |k,v| [k, v.to_f/normalising_factor.to_f] }]
  h.default_proc = proc { |h,k| 0 }
  h
end

def calculate_english_frequency_score(frequency_hash)
  english_letter_frequencies = { 'a' => 0.08167, 'b' => 0.01492, 'c' => 0.02782, 'd' => 0.04253, 'e' => 0.12702, 'f' => 0.0228, 'g' => 0.02015, 'h' => 0.06094, 'i' => 0.06966, 'j' => 0.00153,
                                 'k' => 0.00722, 'l' => 0.04025, 'm' => 0.02406, 'n' => 0.06749, 'o' => 0.07507, 'p' => 0.01929, 'q' => 0.00095, 'r' => 0.05987, 's' => 0.06327, 't' => 0.09056,
                                 'u' => 0.02758, 'v' => 0.00978, 'w' => 0.02361, 'x' => 0.00015, 'y' => 0.01974, 'z' => 0.00074 }
  if frequency_hash.empty? then return 500 end

  normalised_hash = normalise_frequency_hash(frequency_hash)
  chi_squared = 0
  [*('a'..'z')].each do |x|
    chi_squared += ((normalised_hash[x] - english_letter_frequencies[x])**2 / english_letter_frequencies[x])
  end
  chi_squared
end

def single_byte_xor_cypher(cypher_text)
  possible_keys = [*(0..255)].map { |x| binary_to_hex(x) }
  scores = possible_keys.map do |x|
    plain_text = hex_to_binary(xor_against_single_byte(cypher_text, x)).map { |x| x.chr }.join

    next [x, 1000, plain_text] if !plain_text.ascii_only?

    frequency_hash = calculate_letter_frequencies(plain_text)
    #puts "Key #{x}, Score #{calculate_english_frequency_score(frequency_hash)}, Decode #{plain_text}"
    [x, calculate_english_frequency_score(frequency_hash), plain_text]
  end

  key, score, plain_text = scores.min_by { |x| x[1] }
  [plain_text, key]
end

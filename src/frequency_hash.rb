class FrequencyHash
  def initialize(string)
    lf = calculate_letter_frequencies(string)
    @letter_frequencies = normalise_letter_frequencies(lf)
  end

  def [](key)
    @letter_frequencies[key]
  end

  def a_to_z_entries?()
    !@letter_frequencies.empty?
  end

  private
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

  def normalise_letter_frequencies(letter_frequencies)
    normalising_factor = letter_frequencies.values.reduce(:+)
    h = Hash[letter_frequencies.map { |k,v| [k, v.to_f/normalising_factor.to_f] }]
    h.default_proc = proc { |h,k| 0 }
    h
  end
end

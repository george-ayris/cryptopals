require_relative 'frequency_hash.rb'

class EnglishScoreCalculator
  def initialize(potential_english_string)
    @potential_english_string = potential_english_string
    @english_score = calculate_english_score(potential_english_string)
  end

  def text()
    @potential_english_string
  end

  def score()
    @english_score
  end

  def is_more_likely_to_be_english_than(other_calculator)
    @english_score <= other_calculator.score()
  end

  private
  def calculate_english_score(potential_english_string)
    return 1000 unless potential_english_string.ascii_only?

    english_letter_frequencies = { 'a' => 0.08167, 'b' => 0.01492, 'c' => 0.02782,
      'd' => 0.04253, 'e' => 0.12702, 'f' => 0.0228, 'g' => 0.02015, 'h' => 0.06094,
      'i' => 0.06966, 'j' => 0.00153, 'k' => 0.00722, 'l' => 0.04025, 'm' => 0.02406,
      'n' => 0.06749, 'o' => 0.07507, 'p' => 0.01929, 'q' => 0.00095, 'r' => 0.05987,
      's' => 0.06327, 't' => 0.09056, 'u' => 0.02758, 'v' => 0.00978, 'w' => 0.02361,
      'x' => 0.00015, 'y' => 0.01974, 'z' => 0.00074 }

    frequencies = FrequencyHash.new(potential_english_string)

    return 500 unless frequencies.a_to_z_entries?

    chi_squared = 0
    [*('a'..'z')].each do |x|
      chi_squared += ((frequencies[x] - english_letter_frequencies[x])**2 / english_letter_frequencies[x])
    end
    chi_squared
  end
end

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
    @english_score > other_calculator.score()
  end

  private
  def calculate_english_score(potential_english_string)
    return 0 unless potential_english_string.ascii_only?

    number_of_common_letters = potential_english_string.scan(/[ETAOIN SHRDLU]/i).length
    return number_of_common_letters
  end

end

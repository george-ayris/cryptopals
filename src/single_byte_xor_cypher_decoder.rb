require_relative 'english_score_calculator.rb'

class SingleByteXorCypherDecoder
  def initialize(bytes)
    @key, @most_english_calculator = decode(bytes)
  end

  def clear_text
    @most_english_calculator.text()
  end

  def score
    @most_english_calculator.score()
  end

  def key
    @key
  end

  private
  def decode(bytes)
    possible_keys = [*(0..255)]
    scoreCalculators = possible_keys.map do |key|
      xorred_bytes = bytes.xor_with_byte(key)
      [key, EnglishScoreCalculator.new(xorred_bytes.character_representation())]
    end

    mostEnglish = scoreCalculators.reduce { |bestSoFar, current|
      if bestSoFar[1].is_more_likely_to_be_english_than(current[1]) then bestSoFar else current end
    }

    [mostEnglish[0], mostEnglish[1]]
  end
end

require_relative 'english_score_calculator.rb'

class SingleByteXorCypherDecoder
  def initialize(bytes)
    @key, @clear_text = decode(bytes)
  end

  def clear_text
    @clear_text
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

    [mostEnglish[0], mostEnglish[1].text()]
  end
end

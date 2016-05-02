require_relative 'english_score_calculator.rb'
require_relative 'bytes.rb'

class SingleByteXorCypherDecoder
  def initialize bytes
    bytes = Bytes.new bytes if bytes.is_a? String
    @key, @most_english_calculator = decode bytes
  end

  attr_reader :key

  def clear_text
    @most_english_calculator.text
  end

  def score
    @most_english_calculator.score
  end

  private
  def decode bytes
    possible_keys = [*(0..255)]
    scoreCalculators = possible_keys.map do |key|
      xorred_bytes = bytes.xor_with_byte key
      [key, EnglishScoreCalculator.new(xorred_bytes.character_representation)]
    end

    mostEnglish = scoreCalculators.reduce { |bestSoFar, current|
      if bestSoFar[1].is_more_likely_to_be_english_than current[1] then bestSoFar else current end
    }

    [mostEnglish[0], mostEnglish[1]]
  end
end

require_relative 'english_score_calculator.rb'
require_relative 'byte_converter.rb'
require_relative 'xor.rb'

class SingleByteXorCypherDecoder
  def initialize hex_cypher_text
    @key, @most_english_calculator = decode ByteConverter.convert_to_bytes(hex_cypher_text)
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
      xor = Xor.array_with_single_byte bytes, key
      [key, EnglishScoreCalculator.new(xor.character_result)]
    end

    mostEnglish = scoreCalculators.reduce { |bestSoFar, current|
      if bestSoFar[1].is_more_likely_to_be_english_than current[1] then bestSoFar else current end
    }

    [mostEnglish[0], mostEnglish[1]]
  end
end

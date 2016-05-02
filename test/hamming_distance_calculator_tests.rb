require 'minitest/autorun'
require_relative '../src/hamming_distance_calculator.rb'

class HammingDistanceCalculatorTests < MiniTest::Test
  def test_distance_calculation
    calculator = HammingDistanceCalculator.new('this is a test', 'wokka wokka!!!')
    assert_equal 37, calculator.distance()
  end
end

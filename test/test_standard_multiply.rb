require 'test/unit'
require_relative '../kara_int.rb'
require_relative '../standard_multiply.rb'

class TestStandardMultiply < Test::Unit::TestCase

  def setup
    KaraInt.multiply_algorithm = StandardMultiply.new()
  end

  def test_can_multiply_single_digits_3_and_3
    assert_equal "9", KaraInt.new("3") * KaraInt.new("3")
  end

  def test_can_multiply_single_digits_2_and_1
    assert_equal "2", KaraInt.new('2') * KaraInt.new('1')
  end

end


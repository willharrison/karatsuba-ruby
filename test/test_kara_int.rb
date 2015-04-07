require 'test/unit'
require_relative '../kara_int'

class TestKaraInt < Test::Unit::TestCase

  def test_kara_int_must_have_constructor_value
    assert_raise ArgumentError, "Value must be given" do
      KaraInt.new()
    end
  end

  def test_kara_int_initialize_with_string_arg
    assert_instance_of KaraInt, KaraInt.new("1")
  end

  def test_kara_int_raises_exception_with_int_arg
    assert_raise ArgumentError, "Must be of type string" do
      KaraInt.new(1)
    end
  end

  def test_contents_of_n_can_not_be_characters
    assert_raise ArgumentError, "String must consist of numbers" do
      KaraInt.new("foo")
    end
  end

  def test_n_accessor_returns_correct_array_representation
  end

  def test_addition_works_with_small_inputs_1_and_3
    a = KaraInt.new("1")
    b = KaraInt.new("3")
    assert_equal "4", a + b
  end

  def test_addition_works_with_small_inputs_2_and_4
    a = KaraInt.new("2")
    b = KaraInt.new("4")
    assert_equal "6", a + b
  end

  def test_addition_works_with_sum_greater_than_one_digit
    a = KaraInt.new("9")
    b = KaraInt.new("9")
    assert_equal "18", a + b
  end

  def test_addition_works_with_two_digit_inputs_10_and_11
    a = KaraInt.new("10")
    b = KaraInt.new("11")
    assert_equal "21", a + b
  end

  def test_addition_works_with_one_and_two_digit_inputs_15_and_9
    a = KaraInt.new("15")
    b = KaraInt.new("9")
    assert_equal "24", a + b
  end

  def test_addition_works_with_large_numbers
    a = KaraInt.new("3213213513515")
    b = KaraInt.new("98651632133666613")
    assert_equal "98654845347180128", a + b
  end

  def test_substraction_works_with_single_digit_numbers
    a = KaraInt.new("4")
    b = KaraInt.new("2")
    assert_equal "2", a - b
  end

  def test_subtraction_works_with_double_digit_numbers
    a = KaraInt.new("44")
    b = KaraInt.new("20")
    assert_equal "24", a - b
  end

  def test_subtraction_works_with_double_digit_then_single_digit
    a = KaraInt.new("44")
    b = KaraInt.new("2")
    assert_equal "42", a - b
  end

  def test_have_negative_sign_if_given_negative_number
    a = KaraInt.new("-5")
    assert_equal :negative, a.sign
  end

  def test_have_positive_sign_if_given_positive_number
    a = KaraInt.new("5")
    assert_equal :positive, a.sign
  end

  def test_only_allow_sign_at_beginning_of_number
    assert_raise ArgumentError, "Invalid number" do
      KaraInt.new("5-5")
    end
  end

  def test_can_add_numbers_inline
    assert_equal "5", KaraInt.new("1") + KaraInt.new("4")
  end

  def test_can_subtract_single_digit_numbers_to_produce_negative
    assert_equal "-5", KaraInt.new("1") - KaraInt.new("6")
  end

  def test_can_subtract_double_digit_numbers_to_produce_negative
    assert_equal "-5", KaraInt.new("10") - KaraInt.new("15")
  end

  def test_can_subtract_57_and_95
    assert_equal "-38", KaraInt.new("57") - KaraInt.new("95")
  end

end

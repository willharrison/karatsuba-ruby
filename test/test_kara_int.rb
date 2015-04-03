require 'test/unit'
require_relative '../kara_int'

class TestKaraInt < Test::Unit::TestCase

  def test_kara_int_initialize_without_args
    assert_instance_of KaraInt, KaraInt.new()
  end

  def test_kara_int_initialize_with_string_arg
    assert_instance_of KaraInt, KaraInt.new("1")
  end

  def test_kara_int_raises_exception_with_int_arg
    assert_raise ArgumentError, "Must be of type string" do
      KaraInt.new(1)
    end
  end

  def test_kara_int_can_set_n_with_string
    test = KaraInt.new()
    assert_nothing_raised ArgumentError, "Must be of type string" do
      test.n = "1"
    end
  end

  def test_kara_int_can_not_set_n_with_int
    test = KaraInt.new()
    assert_raise ArgumentError, "Must be of type string" do
      test.n = 1
    end
  end

  def test_contents_of_n_can_not_be_characters
    assert_raise ArgumentError, "String must consist of numbers" do
      KaraInt.new("foo")
    end
  end

  def test_n_accessor_returns_correct_array_representation
    test = KaraInt.new("135")
    assert_instance_of Array, test.n
    assert_equal [1, 3, 5], test.n
  end

  def test_n_assessor_raises_error_if_nil
    test = KaraInt.new()
    assert_raise(RuntimeError, "KaraInt#n is undefined") { test.n }
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

end

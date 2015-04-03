require 'test/unit'
require_relative '../array'

class TestArray < Test::Unit::TestCase

  def test_can_pad_array_to_be_certain_size
    a = [1].pad! 3
    b = [1].pad! 31
    assert_equal 3, a.length
    assert_equal 31, b.length
  end

  def test_can_pad_with_correct_output
    a = [1].pad! 5
    assert_equal [0, 0, 0, 0, 1], a
  end

  def test_can_pad_with_two_digits
    a = [10].pad! 15
    assert_equal 15, a.length
    assert_equal [0,0,0,0,0,0,0,0,0,0,0,0,0,0,10], a
  end

  def test_can_not_give_pad_amount_less_than_array_length
    a = [1, 2, 3]
    assert_raise RuntimeError, "Padding length too small" do
      a.pad! 2
    end
  end

  def test_nothing_happens_if_pad_amount_is_equal_to_array_length
    a = [1, 2].pad! 2
    assert_equal [1, 2], a
  end

  def test_pad_is_self_modifying
    a = [1, 2]
    a.pad! 3
    assert_equal [0,1,2], a
  end

  def test_pad_multi_allows_array_of_arrays
    a, b = [1, 2], [5]
    [a, b].pad_multi! 3
    assert_equal [0, 1, 2], a
    assert_equal [0, 0, 5], b
  end

end

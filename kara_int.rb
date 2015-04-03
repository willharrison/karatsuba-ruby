require_relative './array'

class KaraInt 

  attr_reader :n
  attr_reader :sign

  def initialize(value = nil)
    @sign = :positive
    self.n = value
  end

  def valid?(value)
    raise ArgumentError, 'Value must be given' if value.nil?
    raise ArgumentError, 'Must be a string' unless value.is_a? String
    if value !~ /^-{0,1}\d+$/
      raise ArgumentError, 'String must consist of numbers'
    end
  end

  def negative?(value)
    true if @n.first == 0
  end

  def set_negative!
    @sign = :negative
    @n.shift
  end

  def n=(value)
    valid? value
    @n = value.chars.map(&:to_i) 
    set_negative! if negative? value
  end

  def +(other)
    [@n, other.n].pad_multi! [@n.size, other.n.size].max + 1
    result, carry = [], 0
    @n.each_with_index do |item, index|
      current = -1 * (index + 1)
      i = (@n[current] + other.n[current]) + carry
      carry = i > 9 ? 1 : 0
      i -= 10 if i > 9
      result.unshift i
    end
    result.shift if result[0] == 0
    result.join('')
  end

  def -(other)
    [@n, other.n].pad_multi! [@n.size, other.n.size].max + 1
    result = []
    @n.each_with_index do |item, index|
      current = -1 * (index + 1)
      result.unshift @n[current] - other.n[current]
    end
    result.shift if result[0] == 0
    result.join('')
  end

end

require_relative './array'

class KaraInt 

  attr_reader :n
  attr_reader :sign

  def initialize(value = nil)
    valid? value
    @n = value.chars.map(&:to_i) 
    @sign = :negative if negative? value
    @sign = :positive unless negative? value
  end

  def valid?(value)
    raise ArgumentError, 'Value must be given' if value.nil?
    raise ArgumentError, 'Must be a string' unless value.is_a? String
    if value !~ /^-{0,1}\d+$/
      raise ArgumentError, 'String must consist of numbers'
    end
  end

  def negative?(value)
    true if value.chars.first =~ /-/
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
    result.shift while result[0] == 0
    result.join('')
  end

  def -(other)
    x, y = @n, other.n
    if x.size < y.size
      x, y = y, x
      @sign = :negative
    elsif x.size == y.size
      x.each_with_index do |item, index|
        if x[index] < y[index]
          x, y = y, x
          @sign = :negative
          break
        end
      end
    end
    [@n, other.n].pad_multi! [@n.size, other.n.size].max + 1
    result, carry = [], 0
    x.each_with_index do |item, index|
      current = -1 * (index + 1)
      a, b = x[current] - carry, y[current]
      carry = 0
      carry = 1 if b > a
      a += 10 if b > a
      i = a - b
      result.unshift i
    end
    result.shift while result[0] == 0
    result.unshift '-' if @sign == :negative
    result = result.join('')
    result
  end

end

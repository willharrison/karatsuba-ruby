require_relative './array'

class KaraInt 

  def initialize(value = nil)
    self.n = value unless value.nil? 
  end

  def n=(value)
    raise ArgumentError, 'Must be a string' unless value.is_a? String
    raise ArgumentError, 'String must consist of numbers' if value !~ /\d/
    @n = value.split('').map(&:to_i) 
  end

  def n
    raise "KaraInt#n is undefined" if @n.nil?
    @n
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
    result = []
    result.unshift @n[-1] - other.n[-1]
    result.join('')
  end

end

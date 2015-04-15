require 'benchmark'
require 'gruff' # Needed for graph

class GradeSchool
  def multiply(a, b)
    result = 0
    carry = [0]
    b.to_s.chars.reverse.each_with_index do |b, index_b|
      a.to_s.chars.reverse.each_with_index do |a, index_a|
        r = simply_multiply(a[index_a].to_i, b[index_b].to_i) + carry.map(&:to_s).join('').to_i
        carry = [0]
        carry = r[0...-1] if r > 10
        tail = r[-1]
        ((b.to_s.length - index_b) + (a.to_s.length - index_a)).times do |n|
          tail << 0
        end
        result += tail
      end
      (result.to_s.length - 1).times { |n| carry << 0 }
      result += carry.map(&:to_s).join('').to_i
      carry = [0]
    end
    result
  end

  def exponent(a, b)
    result = 1
    b.times do |n|
      result = multiply(a, result)
    end
    result
  end

  def simply_multiply(a, b)
    r = 0
    a.to_s.chars.reverse.each do |n|
      r += b
    end
    r
  end
end

class Karatsuba
  def initialize
    @gs = GradeSchool.new
  end

  def multiply(a, b)
    return @gs.multiply(a, b) if a.to_s.length < 10 || b.to_s.length < 10
    m = [a.to_s.length, b.to_s.length].max
    m2 = m / 2

    high1 = a.to_s.chars.first(m2).join('').to_i
    high2 = b.to_s.chars.first(m2).join('').to_i
    low1 = a.to_s.chars[m2..-1].join('').to_i
    low2 = b.to_s.chars[m2..-1].join('').to_i

    z0 = multiply(low1, low2)
    z1 = multiply((low1 + high1), (low2 + high2))
    z2 = multiply(high1, high2)

    return @gs.multiply(z2, @gs.exponent(10, m)) + 
      @gs.multiply((z2-z0-z1), @gs.exponent(10, m2)) + (z0)
  end
end

if __FILE__ == $0
  digit_lengths = {}
  digit_lengths_ary = []
  karatsuba_times = []
  grade_school_times = []

  grade_school = GradeSchool.new
  karatsuba = Karatsuba.new
  200.times do |n|
    a, b = rand(1..2**(n * 5)-1), rand(1..2**(n * 5)-1)
    time_a = Benchmark.realtime { grade_school.multiply a, b}
    time_b = Benchmark.realtime { karatsuba.multiply a, b }
    printf "%-20s", time_a * 1000 if time_a > time_b
    printf "\e[#{32}m%-20s\e[0m", time_a * 1000 if time_a < time_b
    printf "%-20s", time_b * 1000 if time_b > time_a
    printf "\e[#{32}m%-20s\e[0m", time_b * 1000 if time_b < time_a
    printf "Digit Length: #{a.to_s.length}, #{b.to_s.length}"

    digit_lengths[n] = "(#{a.to_s.length}, #{b.to_s.length})" if n % 40 == 0

    digit_lengths_ary << "#{a.to_s.length}, #{b.to_s.length}"
    grade_school_times << time_a * 1000
    karatsuba_times << time_b * 1000

    puts
  end

  File.open('data.txt', 'w') do |file|
    file.printf "%-20s%-20s\n", "Grade School", "Karatsuba"
    file.puts '-' * 40
    200.times do |n|
      file.printf "%-20s", grade_school_times[n] * 1000 if grade_school_times[n] > karatsuba_times[n]
      file.printf "*** %-20s", grade_school_times[n] * 1000 if grade_school_times[n] < karatsuba_times[n]
      file.printf "%-20s", karatsuba_times[n] * 1000 if karatsuba_times[n] > grade_school_times[n]
      file.printf "*** %-20s", karatsuba_times[n] * 1000 if karatsuba_times[n] < grade_school_times[n]
      file.printf "Digit Length: %s\n", digit_lengths_ary[n]
    end
  end

  g = Gruff::Line.new
  g.title = 'Grade School vs Karatsuba'
  g.labels = digit_lengths
  g.data :GradeSchool, grade_school_times
  g.data :Karatsuba, karatsuba_times
  g.write('gsvk_line.png')

end


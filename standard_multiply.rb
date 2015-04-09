class StandardMultiply

  def calculate(a, b)
    result = "0"
    a = a.to_s
    until a == "0"
      result = KaraInt.new(result.to_s) + b
      a = KaraInt.new(a.to_s) - KaraInt.new("1")
    end
    puts result
  end

end

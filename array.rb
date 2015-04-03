class Array

  def pad!(length)
    raise "Padding length too small" if self.length > length
    self.reverse!.fill(0, self.length...length).reverse!
  end

  def pad_multi!(length)
    self.each { |i| i.pad! length }
  end

end

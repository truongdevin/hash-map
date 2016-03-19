class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.to_s.chars.map(&:ord).inject {|a,b| 15*a.hash + 27*b.hash }
  end
end

class String
  def hash
    self.chars.map {|letter| letter.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.sort.to_a.to_s.hash
  end

end

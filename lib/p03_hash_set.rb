require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= @store.length
    @store[num.hash % @store.length] << num
    @count += 1
  end

  def remove(num)
    @store[num.hash % @store.length].delete(num)
  end

  def include?(num)
    @store[num.hash % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(2 * @count) {Array.new}
    @store.flatten.each do |val|
      new_store[val % new_store.length] << val
    end
    @store = new_store
  end
end

require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @store[num.hash % @store.length] << num
    @count += 1
    resize! if @count >= @store.length
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
    old_store = @store
    @store = Array.new(2 * @count) { Array.new }
    @count = 0
    old_store.flatten.each do |val|
      insert(val)
    end
    @store
  end
end

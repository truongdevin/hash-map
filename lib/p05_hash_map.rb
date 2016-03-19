require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def set(key, val)
    delete(key) if include?(key)
    @store[key.hash % @store.length].insert(key, val)
    @count += 1
    resize! if @count >= @store.length
  end

  def get(key)
    @store[key.hash % @store.length].get(key)
  end

  def delete(key)
    @store[key.hash % @store.length].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  #uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(3 * @count) { LinkedList.new }
    @count = 0
    old_store.each do |list|
      list.each do |link|
        self.set(link.key, link.val)
      end
    end
    @store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

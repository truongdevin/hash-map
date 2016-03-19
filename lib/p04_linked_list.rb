class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  # def inspect
  #   "#{@key}: #{@val}"
  # end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail
  end

  def get(key)
    link = get_link(key)
    link.nil? ? nil : link.val
  end

  def include?(key)
    !get_link(key).nil?
  end

  def insert(key, val)
    new_node = Link.new(key,val)
    last.next = new_node
    new_node.prev = last
    new_node.next = @tail
    @tail.prev = new_node
  end

  def remove(key)
    link = get_link(key)
    return if link.nil?
    link.next.prev = link.prev
    link.prev.next = link.next
  end

  def get_link(key)
    current_node = self.first

    until current_node.key == key
      current_node = current_node.next
      return nil if current_node.nil?
    end
    current_node
  end

  def each(&prc)
    current_node = self.first

    until current_node.next == nil
      prc.call(current_node)
      current_node = current_node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

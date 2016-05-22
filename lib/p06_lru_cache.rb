require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.get(key)
      update_link!(@map.get(key))
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if count >= @max
    val = @prc.call(key)
    @store.insert(key, val)
    @map.set(key, @store.last)
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev

    @store.last.next = link
    link.prev = @store.last

    @store.tail.prev = link
    link.next = @store.tail
  end

  def eject!
    link = @store.first
    @store.head.next = link.next
    @store.first.prev = @store.head
    @map.delete(link.key)
  end
end

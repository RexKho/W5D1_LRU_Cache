class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next 
    @next.next = @prev
    @next, @prev = nil, nil 
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
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
    @head.next.val == @tail.val #|| @tail.prev == @head 
  end

  def get(key)
    current = first
    until current.key == key || current == @tail 
      current = current.next
    end 
    current.val if current != @tail 
  end

  def include?(key)
  end

  def append(key, val)
    new_node = Node.new(key,val)
    #tail's previous node's next 
    @tail.prev.next = new_node
    #new node's next points to tail 
    new_node.next = @tail 
    #updates tail's prev 
    @tail.prev = new_node
  end

  def update(key, val)
    current = first
    until current.key == key || current == @tail 
      current = current.next
    end 
    current.val = val if current.key == key
  end

  def remove(key)
    current = first
    until current.key == key || current == @tail 
      current = current.next
    end 

    if current.key == key
      next_node = current.next #4
      prev_node = current.prev #2
      next_node.prev = prev_node
      prev_node.next = next_node 
      current.next = nil 
      current.prev = nil 
    end 

  end

  def each(&prc)
    current = @head.next
    until current == @tail
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end

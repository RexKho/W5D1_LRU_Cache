class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
    
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num]

  end

  def remove(num)
    @store[num % num_buckets] -= [num]
   
  end

  def include?(num)
    if @store[num % num_buckets].include?(num)
      return true 
    end 
    false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket_i = num % @store.length
    @store[bucket_i] << num 
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self[num].include?(num)
      self[num] << num 
      @count += 1 
    end
    self.resize! if @count == @store.length
  end

  def remove(num)
    if self[num].include?(num)
      idx = self[num].index(num)
      self[num].slice!(idx)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket_i = num % @store.length
    @store[bucket_i]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newstore = Array.new(@store.length*2) { Array.new }
    @store.each do |bucket|
      bucket.each do |ele2|
        newstore[ele2 % newstore.length] << ele2
      end
    end
    @store = newstore
  end
end

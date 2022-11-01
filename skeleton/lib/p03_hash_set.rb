class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    # p @store
    if !self[key].include?(key)
      self[key].push(key)
      @count += 1
    end
    if @count >= @store.length
      resize!
    end
  end

  def include?(key)
    self[key].include?(key)
    
  end

  def remove(key)

    if self[key].include?(key) 
      self[key].slice!(self[key].index(key))
      @count -=1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket_i = num.hash % @store.length
    @store[bucket_i]
    
  end

  def num_buckets
    @store.length
  end

  def resize!
    newstore = Array.new(@store.length*2) { Array.new }
    @store.each do |bucket|
      bucket.each do |ele2|
        newstore[ele2.hash % newstore.length] << ele2
      end
    end
    @store = newstore
  end
end

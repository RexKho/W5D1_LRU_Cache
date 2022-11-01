class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 2450505152024043577 if self.length == 0
    hash_num = self[0].hash
    self[1..-1].each do |ele|
      hash_num %= ele.hash
    end 
    hash_num
  end
end

class String
  def hash
    alpha = ('a'..'z').to_a
    hash_num = alpha.index(self[0]).hash 
    self[1..-1].each_char do |char|
      hash_num %= alpha.index(char).hash
    end 
    hash_num
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    if self.length == 0
      return -3666228186350638169 
    end 
    keys = self.keys 
    hash_num = keys[0].hash + self[keys[0]].hash 
    keys[1..-1].each do |key|
      hash_num += key.hash + self[key].hash
    end 
    hash_num 
  end
end

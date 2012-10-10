# ruby encoding: utf-8
Infinity = 1.0/0        unless defined? Infinity
Googol   = 10**100      unless defined? Googol

# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | Object | String | Symbol | *Numeric* |  
# [ ] | Numeric | Integer | *Float* |  
#
# ---
#
# == *Float* 
#
#
class Float

  #  1.9 == 1.8 + 0.1               => false
  #  1.9.approx(1.8 + 0.1)          => true
  #  98.6.approx(98.66)             => false
  #  98.6.approx(98.66, 0.001)      => true
  # Copyright 2006 O'Reilly Media, Ruby Cookbook, by Lucas Carlson and Leonard Richardson
  #
  def approx(other, relative_epsilon=Float::EPSILON, epsilon=Float::EPSILON)
    difference = other - self
    return true if difference.abs <= epsilon
    relative_error = (difference / (self > other ? self : other)).abs
    return relative_error <= relative_epsilon
  end
  # http://oreilly.com/catalog/9780596523695/
  # Ruby Cookbook, by Lucas Carlson and Leonard Richardson
  # Copyright 2006 O'Reilly Media  


  
end
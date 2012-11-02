# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

Infinity = 1.0/0        unless defined? Infinity
Googol   = 10**100      unless defined? Googol



# @!macro numeric
class Float

  # Fuzzy comparison of Floats. Example:
  #  (98.6).fuzzy_equal?(98.66)          => false
  #  (98.6).fuzzy_equal?(98.66, 0.001)   => true
  #
  # @param other [Float] Value to compare with
  # @param error_max [Float] Maximum relative error
  def fuzzy_equal?(other, error_max=0.000001)
    diff = other - self
    return true if diff.abs <= Float::EPSILON
    relative_error = (diff / (self > other ? self : other)).abs
    #puts relative_error
    return relative_error <= error_max
  end



  
end

# -----------------------------------------------------------------------------------------
#  ausprobieren
#
if $0 == __FILE__ then

  puts (98.6).fuzzy_equal?(98.66)
  puts (98.6).fuzzy_equal?(98.66, 0.001)

end # if
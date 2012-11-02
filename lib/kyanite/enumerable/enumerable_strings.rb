# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end




# @!macro enum_of_strings
module EnumerableStrings

  # Delete every element from the front with is identical with the back -- leave the significant middle part.
  # Example: 
  #  ['lut', 'lutm', 'lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri', 'lutr', 'lut'].palindrom_rumpf  =>
  #  ['lutm', 'lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri', 'lutr']
  #
  def palindrom_rumpf
    result = self.dup
    0.upto( size/2 - 1 ) do |i|
      if result[0] == result[-1]
        result.delete_at(0)   
        result.delete_at(-1)  
      end
    end
    result
  end




end




# @!macro enum_of_strings
class ArrayOfStrings < Array
  include EnumerableStrings
end

  

class Array

  # @!group Cast
  # Returns {ArrayOfStrings} (this is an {Array} with modul {EnumerableStrings} included)
  # @return [ArrayOfStrings]
  def to_array_of_strings
    ArrayOfStrings.new(self)
  end
  #@!endgroup
  
end







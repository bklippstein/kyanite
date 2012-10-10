# ruby encoding: utf-8 
# ü

# [ | Kyanite | Object | Array | Set | *Enumerable* | Hash | ]     | Enumerable | EnumerableNumerics | *EnumerableStrings* | EnumerableEnumerables | 
# ---
#
#
# == *Enumeration* *Of* *Strings*
# See TestKyaniteEnumerableStrings for tests and examples.
# See ArrayOfStrings for an Array with modul EnumerableStrings included. 
#
# 
module EnumerableStrings


  # Bsp.: 
  #  ['lut', 'lutm', 'lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri', 'lutr', 'lut'].palindrom_rumpf  =>
  #  ['lutm', 'lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri', 'lutr']
  # d.h. vorne und hinten wird alles Gleiche weggestrichen.
  #
  # Tests and examples see TestKyaniteEnumerableStrings.
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



# [ | Kyanite | Object | *Array* | Set | Enumerable | Hash | ]     | Array |  ArrayOfNumerics  | *ArrayOfStrings* |  ArrayOfEnumerables | Range |  
# ---
#
#
# == *Array* *Of* *Strings*
# An ArrayOfstrings is an Array with modul EnumerableStrings included. 
# See TestKyaniteEnumerableStrings for tests and examples.
#
class ArrayOfStrings < Array
  include EnumerableStrings
end



class Array

  # Liefert ein ArrayOfStrings (das ist ein Array mit inkludiertem Modul EnumerableStrings)
  def to_array_of_strings
    ArrayOfStrings.new(self)
  end
  
end







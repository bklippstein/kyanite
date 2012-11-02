# ruby encoding: utf-8
#
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'facets/array/delete'           # Methoden delete_unless, delete_values, delete_values_at
require 'facets/array/rotate'           # Methoden rotate, rotate!
require 'facets/array/select'           # Methode select!
require 'facets/to_hash'                # Methode to_h (in der Facets-Bibliothek falsch einsortiert?)

require 'kyanite/enumerable/enumerable_enumerables'
require 'kyanite/enumerable/enumerable_numerics'
require 'kyanite/enumerable/enumerable_strings'
require 'kyanite/enumerable'            #  ist eigentlich nicht nötig?
require 'kyanite/general/object'        # Methode respond
require 'kyanite/general/classutils'    # <=> für class
require 'kyanite/symbol'                # size 



# @!macro array
#
# === Required from {http://rubyworks.github.com/rubyfaux/?doc=http://rubyworks.github.com/facets/docs/facets-2.9.3/core.json#api-class-Array Facets Array}:  
# [+delete_unless(&block)+]         Inverse of +delete_if+
# [+delete_values(*values)+]        Delete multiple values from array (findet und löscht bestimmte Werte)
# [+delete_values_at(*selectors)+]  Delete multiple values from array given indexes or index range (löscht Elemente an bestimmten Positionen)
# [+rotate(n=1)+]                   Rotates an array's elements from back to front n times (alles rückt n Positionen auf)
# [+select!{ |obj| block }+]        As with +select+ but modifies the Array in place.
# [+to_h(arrayed=nil)+]             Converts a two-element associative array into a hash. 
# 
class Array    
 
  
  # Cuts the front portion, and returns the rest.
  # If the remainder is only one element, it' not returned as an array but as single element.
  # Useful for recursions. Example:  
  #   [1,2,3].shift_complement  =>  [2,3]
  #   [1,2,3].shift_complement.shift_complement  =>  3
  #   [1,2,3].shift_complement.shift_complement.shift_complement  =>  nil
  #
  # See tests and examples {TestKyaniteArray#test_array_shift_complement here}.
  #
  def shift_complement
    if self.size > 2
      self[1..-1]
    else
      self[-1]
    end
  end
  
  

  
  
  # Rephrases the index of an Array pos / neg / inv.
  # [:pos]     The index is rephrased as a positive integer
  # [:neg]     The index is rephrased as a negative integer 
  # [:inv]     if it was positive, then it will get negative, and vice versa
  # 
  # @return [Integer]
  #
  # See tests and examples {TestKyaniteArray#test_rephrase_index here}
  #
  def rephrase_index(i, style=:inv)
    return i    if i >  (size-1)
    return i    if i <  -size
    case style
    when :inv
          if i >=0    # pos >> neg
            (i - size)
          else        # neg >> pos
            (i + size)
          end
    when :pos
          if i >= 0   # pos bleibt
            i
          else        # neg >> pos
            (i + size)
          end    
    when :neg
          if i >= 0   # pos >> neg
            (i - size)
          else        # neg bleibt
            i
          end    
    end #case
  end #def
  
 


end #  class Array         




if defined? TransparentNil
  class NilClass
    def shift_complement;               nil;            end  
  end
end
    
    
class Numeric
  # +nil+, Complements {Array#shift_complement}.
  # @return [NilClass]  
  def shift_complement 
    nil
  end  
end    





    
    
    
    


    
    
    
    
    
    

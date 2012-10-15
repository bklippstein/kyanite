# ruby encoding: utf-8

module Enumerable

 # In-place-Variante von transpose. 
  def transpose!
      self.replace(self.transpose)
  end    


end

# [ | Kyanite | Object | Array | Set | *Enumerable* | Hash | ]     | Enumerable | EnumerableNumerics | EnumerableStrings | *EnumerableEnumerables* | 
# ---
#
#
# == *Enumeration* *Of* *Enumerations*
# Für zweidimensionale Enumerables bzw. Aufzählungen von Objekten, die wiederum aufzählbar sind.
# See TestKyaniteEnumerableEnumerables for tests and examples.
# See ArrayOfEnumerables for an Array with modul EnumerableEnumerables included. 
#
#
module EnumerableEnumerables

  # Macht das Enumerable rechteckig.
  # Maßgeblich ist die erste Zeile.
  #
  # Tests and examples see TestKyaniteEnumerableEnumerables.
  def rectangle
    qsize = self[0].size   
    result = []
    self.each do |zeile|
      size_diff = qsize - zeile.size  
      # so lassen oder zuschneiden      
      if size_diff <= 0
        result << zeile[0..qsize-1]
      # ergänzen
      else
        result << zeile + ([nil] * size_diff)
      end # if
    end # each zeile   
    result
  end # def

end



# [ | Kyanite | Object | *Array* | Set | Enumerable | Hash | ]     | Array |  ArrayOfNumerics  | ArrayOfStrings |  *ArrayOfEnumerables* | Range |  
# ---
#
#
# == *Array* *Of* *Enumerations*
# An ArrayOfEnumerables is an Array with modul EnumerableEnumerables included. 
# See TestKyaniteEnumerableEnumerables for tests and examples.
#
class ArrayOfEnumerables < Array   
  include EnumerableEnumerables
end


class Array

  # Liefert ein ArrayOfEnumerables (das ist ein Array mit inkludiertem Modul EnumerableEnumerables)
  def to_array_of_enumerables
    ArrayOfEnumerables.new(self)
  end
end


if defined? TransparentNil
  class NilClass
    def transpose!;                     nil;            end  
    def transpose;                      nil;            end  
    def rectangle;                      nil;            end  
  end
end






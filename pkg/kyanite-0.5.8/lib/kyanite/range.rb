# ruby encoding: utf-8
require 'facets/range/combine'
require 'facets/range/within'
require 'kyanite/enumerable'             # is_collection? ist für Ranges false

# [ | Kyanite | Object | *Array* | Set | Enumerable | Hash | ]     | Array |  ArrayOfNumerics  | ArrayOfStrings |  ArrayOfEnumerables | *Range* |  
# ---
#
#
# == *Range*
#
#
# Aus {Facets/Range}[http://facets.rubyforge.org/doc/api/core/classes/Range.html] eingefügt:  
#  umbrella(range)
#  within?
#  combine(range)
#
#
class Range

  # Invertiert den Range, mit dem ein Ausschnitt eines Strings oder eines Arrays bestimmt wird.
  # Liefert einen Range, mit dem der inverse Teil des Strings ausgewählt werden kann.
  # Beispiele siehe TestKyaniteRange.
  #
  def invert_index
  
    # hinteren Teil ausgeben
    if first == 0
      return (1..0)           if last == -1     # leer
      return (last+1..-1)                       # hinterer Teil

    # vorderen Teil ausgeben
    else 
      return (0..first-1)     if last == -1     # vorderer Teil
      
    end
    
    # äußere Teile ausgeben
    return [(first..-1).invert_index, (0..last).invert_index]
  end # def

 
  
end # class
  
  
  


class NilClass
  def invert_index;                         nil;              end     
  def umbrella(*a);                   nil;              end     
  def combine(*a);                    nil;              end     
  def within?(*a);                    nil;              end     
end

    
  
    
    
    

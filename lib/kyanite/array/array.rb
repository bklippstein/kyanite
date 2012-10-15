# ruby encoding: utf-8
require 'facets/array/delete'           # Methoden delete_unless, delete_values, delete_values_at
require 'facets/array/rotate'           # Methoden rotate, rotate!
require 'facets/array/select'           # Methode select!
require 'facets/to_hash'                # Methode to_h (in der Facets-Bibliothek falsch einsortiert?)

require 'kyanite/enumerable/enumerable_enumerables'
require 'kyanite/enumerable/enumerable_numerics'
require 'kyanite/enumerable/enumerable_strings'
require 'kyanite/general/object'        # Methode respond
require 'kyanite/general/classutils'    # <=> für Class
require 'kyanite/symbol'                # size 

# [ | Kyanite | Object | *Array* | Set | Enumerable | Hash | ]     | *Array* |  ArrayOfNumerics  | ArrayOfStrings |  ArrayOfEnumerables | Range | 
# ---
#  
# == *Tools* *And* *Casts* *For* *Array*
# See TestKyaniteArray for tests and examples.
#
#
# Aus {Facets/Array}[http://facets.rubyforge.org/doc/api/core/classes/Array.html] eingefügt:
# [*delete_unless*      (&block)]               Ergänzung zum regulären +delete_if+
# [*delete_values*      (*values)]              Findet und löscht bestimmte Werte 
# [*delete_values_at*   (*selectors)]           Löscht Elemente an bestimmten Positionen
# [ ] .
# [*rotate*             (n=1)]                  Alles rückt n Positionen auf
# [<b>select!</b>       { |obj| block }]        Wie +select+, aber modifiziert das Objekt
# [*to_h*               (arrayed=nil)]          Converts a two-element associative array into a hash. 
# [*to_hash*            ()]                     (Unterschied zu +to_h+ ???)   
# 
class Array    
 
  # schneidet vorne ein Element ab und gibt den Rest zurück.
  # Wenn der Rest nur noch aus einem Element besteht, wird er 'pur' zurückgeliefert und nicht als Array.
  # Nützlich für Rekursionen. Bsp.:
  #   [1,2,3].shift_complement  =>  [2,3]
  #   [1,2,3].shift_complement.shift_complement  =>  3
  #   [1,2,3].shift_complement.shift_complement.shift_complement  =>  nil
  #
  # Tests and examples see TestKyaniteArray#test_array_shift_complement
  #
  def shift_complement
    if self.size > 2
      self[1..-1]
    else
      self[-1]
    end
  end
  
  

  
  
  # Formuliert den Index eines Arrays
  #  :pos     als positive Angabe
  #  :neg     als negative Angabe
  #  :inv     wenn positiv, dann negativ und umgekehrt 
  # 
  # Liefert eine Integerzahl.
  #
  # Tests and examples see TestKyaniteArray#test_rephrase_index
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
  
  
  
  
  
  
# ==================================================================================
# Zufall
#      
  
  
  # Bringt das Array in eine zufällige Reihenfolge
  def shuffle
    sort_by { rand }
  end

  
  # In-place-Variante von shuffle
  def shuffle!
    self.replace shuffle
  end  
  


end #  class Array         




if defined? TransparentNil
  class NilClass
    def shift_complement;               nil;            end  
  end
end
    
    
    





    
    
    
    


    
    
    
    
    
    

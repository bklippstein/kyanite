# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'set'
require 'kyanite/enumerable'             # is_collection? 
require 'kyanite/general/kernel'         # silence_warnings
require 'kyanite/dictionary'             # Geordneter Hash
require 'kyanite/symbol'                 # damit man auch Symbols aufnehmen kann
require 'kyanite/hash'                   # Korrektur der Methoden hash und eql?


# [ | Kyanite | Object | Array | *Set* | Enumerable | Hash | ]     | *Set* | OrderedSet | SortedSet | 
# ---
#
#
# == *General* *Set*
# Tests and examples see TestKyaniteSet
#
#
# === Unterschiede der verschiedenen Set-Klassen
# * Ein {Set}[http://www.ruby-doc.org/core/classes/Set.html] ist ungeordnet.                 
#   Beispiele:  TestKyaniteSet#test_set
# * Ein OrderedSet ist geordnet, es behält die ursprüngliche Reihenfolge, wird aber nicht kontinuierlich neu sortiert.
#   Es sei denn, man sorgt dafür mit Dictionary#order_by      
#   Beispiele:  TestKyaniteSet#test_ordered_set
# * Ein {SortedSet}[http://www.ruby-doc.org/core/classes/SortedSet.html] ist geordnet und sortiert. Es behält immer die Sortierung.       
#   Beispiele:  TestKyaniteSet#test_sorted_set
#
class Set

  # Fügt das Element an das Set an.
  def push(elt)
    self << elt
  end
  
  
  # Vergleichsoperator, Standardsortierung: Size
  def <=>(other)
    self.size <=> other.size
  end
  
  # def hash_raw
    # @hash
  # end
  
  # Liefert irgendein Element.  
  def first
    @hash.each do |key, value|
      return key
    end  
  end #def
  
  
  # Liefert irgendein anderes Element.  
  def last
    first = nil
    @hash.each do |key, value|
      if first.nil?
        first = key
        next
      else
        return key
      end #if
    end #do 
  end #def 
  
end


# [ | Kyanite | Object | Array | *Set* | Enumerable | Hash | ]     | Set | *OrderedSet* | SortedSet | 
# ---
#
#
# == *Ordered* *Set*
# Tests and examples see TestKyaniteSet
#
# Ein OrderedSet ist geordnet, es behält die ursprüngliche Reihenfolge, wird aber nicht kontinuierlich neu sortiert.
# Es sei denn, man sorgt dafür mit Dictionary#order_by  
#
class OrderedSet < Set

  def initialize(enum = nil, &block) # :yields: o
    @hash ||= Dictionary.new
    enum.nil? and return
    if block
      enum.each { |o| add(block[o]) }
    else
      merge(enum)
    end
  end
  
  
  # Liefert das n-te Element.
  def [](index)
    @hash.order[index]
  end
  
  
  def zugrundeliegendes_dictionary # :nodoc:
    @hash
  end
  
  # Liefert ein entsprechendes Array.
  # Diese Methode ist schnell. Es muss nichts umgeformt werden. Andere Methoden können also gerne auf to_a basieren. 
  def to_a 
    @hash.order
  end  
  

  def ==(other)
    silence_warnings do   
      self.to_a.to_set == other.to_a.to_set
    end
  end  

  # Wie Array#index
  def index(object)
    self.to_a.index(object)
  end
  
  def each
    to_a.each { |e| yield( e ) }
    self
  end
  
  def order_by( &block )
    @hash.order_by( &block )
  end
  
  def first
    self[0]
  end
  
  def last
    self[-1]
  end    
  
  
  
end # class
  
  
# [ | Kyanite | Object | | Array | *Set* | Enumerable | Hash ]     | Set | OrderedSet | *SortedSet* | 
# ---
#
#
# == *Sorted* *Set*
# Tests and examples see TestKyaniteSet
#
# Ein {SortedSet}[http://www.ruby-doc.org/core/classes/SortedSet.html] ist geordnet und sortiert. Es behält immer die Sortierung.       
# Beispiele:  TestKyaniteSet#test_sorted_set
#
class SortedSet 

  # Liefert das n-te Element.
  # ineffizient!!
  def [](index)
    self.to_a[index]
  end
  
  def first
    self[0]
  end
  
  def last
    self[-1]
  end  
  
  # das war mal auskommentiert, wird aber von nat_lang gebraucht
  def unshift(e) # :nodoc:
    self << e
  end
  
  def to_sorted_set
    self
  end    
  
end # class 




  
class Array

  # Liefert ein OrderedSet, das dem Array entspricht. 
  # Übersicht über die verschiedenen Set-Klassen siehe Set.
  # Tests siehe TestKyaniteSet#test_ordered_set    
  def to_ordered_set
    OrderedSet.new(self)
  end
  
  # Liefert ein SortedSet, das dem Array entspricht. 
  # Übersicht über die verschiedenen Set-Klassen siehe Set.  
  # Tests siehe TestKyaniteSet#test_sorted_set
  def to_sorted_set
    SortedSet.new(self)
  end      
  
  
end # class
  
  
class Object

  # Liefert ein Set mit einem Element
  #
  def to_set; Set.new([self]); end
  
end


if defined? TransparentNil
  class NilClass

    # Rückgabe: Leeres Set
    def to_set;                         Set.new;              end   

    # Rückgabe: Leeres SortedSet
    def to_sorted_set;                  SortedSet.new;        end    

    # Rückgabe: Leeres OrderedSet
    def to_ordered_set;                 OrderedSet.new;       end     
  end
end




    
# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 


  puts nil.to_set

  # test = [:a, :b, :c].to_ordered_set
  # see :test # .inspect_see
  # see_pp test
  # seee.process_print( test, :method => :pp )
  # see :test# .inspect_see

end


    
  
    
    
    

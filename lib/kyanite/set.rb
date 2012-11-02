# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'set'
require 'kyanite/enumerable'             # is_collection? 
require 'kyanite/general/kernel'         # silence_warnings
require 'kyanite/dictionary'             # Geordneter Hash
require 'kyanite/symbol'                 # damit man auch Symbols aufnehmen kann
require 'kyanite/hash'                   # Korrektur der Methoden hash und eql?









# @!macro set
class Set

  # Adds the element to the set.
  def push(elt)
    self << elt
  end
  
  
  # Comparison operator (by size)
  # @return [Integer] 1, 0, -1
  def <=>(other)
    self.size <=> other.size
  end
  
  # def hash_raw
    # hash
  # end
  

  # @return any element
  def first
    @hash.each do |key, value|
      return key
    end  
  end #def
  
  
  # @return any other element  
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



# =================================================================================================================
# @!macro set
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
  
  
  # @return n-th Element
  def [](index)
    @hash.order[index]
  end
  
  # @private  
  def zugrundeliegendes_dictionary 
    @hash
  end

  
  # This method is fast. Nothing needs to be converted. 
  # @return [Array]
  def to_a 
    @hash.order
  end  
  
  
  # @return [Boolean]
  def ==(other)
    silence_warnings do   
      self.to_a.to_set == other.to_a.to_set
    end
  end  

  # like Array#index
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
  
  # @return first element  
  def first
    self[0]
  end
  
  # @return last element  
  def last
    self[-1]
  end    
  
  
  
end # class
  
  

# =================================================================================================================
# @!macro set
# 
class SortedSet 

  # @return n-th Element
  # n-th Element. inefficient!!
  def [](index)
    self.to_a[index]
  end
  
  # @return first element    
  def first
    self[0]
  end
  
  # @return last element    
  def last
    self[-1]
  end  
  
  # das war mal auskommentiert, wird aber von nat_lang gebraucht
  # @private
  def unshift(e) 
    self << e
  end
  
  # @return self   
  def to_sorted_set
    self
  end    
  
end # class 



# ===========================================================================================================================
#
  
class Array

  # @!group Cast  
  
  # Returns {OrderedSet}, tests and examples {TestKyaniteSet#test_ordered_set here}.
  # @return [OrderedSet]
  def to_ordered_set
    OrderedSet.new(self)
  end
  
  
  # Returns {SortedSet}, tests and examples {TestKyaniteSet#test_sorted_set here}.
  # @return [SortedSet]  
  def to_sorted_set
    SortedSet.new(self)
  end      
  
  # @!endgroup  
  
end # class
  
  
class Object


  # Returns {Set} with one element
  # @return [Set] with one element
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


    
  
    
    
    

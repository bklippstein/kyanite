# ruby encoding: utf-8

if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


require 'kyanite/general/object'
require 'kyanite/array/array'
require 'kyanite/dictionary' 




class Object

  # @!macro [new] is_collection
  #  -- Defined for all objects: Do I contain multiple objects? {String} and {Range} are not considered as collection.
  # 
  #  Tests and examples {TestKyaniteEnumerableStructure#test_is_collection here}.
  
  # +false+  
  # @!macro is_collection  
  # @return [false]
  def is_collection?;                 false;          end
  
end


class Range 

  # +false+  
  # @!macro is_collection  
  # @return [false]
  def is_collection?;                 false;          end
  
end



class String 

  # @!group Miscellaneous
  # +false+  
  # @!macro is_collection  
  # @return [false]
  def is_collection?;                 false;          end
  # @!endgroup   
end


  # @!group Structure Reflection
  
module Enumerable

  # @!macro is_collection
  # +true+  
  # @!macro is_collection  
  # @return [true]
  def is_collection?;                 true;          end
  
end  





# @!macro enumerable
module Enumerable

  # Returns the distribution of +size+, +class+ or any other characteristics of the enumerated elements.
  # See also {Hash#distribution}. Tests and examples {TestKyaniteEnumerableStructure#test_distribution_class here}.
  # @return [Array]
  def distribution( mode = :size)
    verteilung = Hash.new
    each do | element |
      value = element.respond(mode)
      if verteilung.has_key?(value)
        verteilung[value] += 1
      else
        verteilung[value] = 1
      end # if      
    end #each
    verteilung.to_a.sort   
  end
  
  
  
  # What kind of objects contains the collection?
  # Returns the class of content elements, or +Object+ if there are several.
  #
  # Parameters is the accuracy with which the content is checked.  
  # [:precision  => 1]      only the first element is checked
  # [:precision  => 2]      the first and the last elements are checked      (STANDARD)
  # [:precision  => :all]   every element is checked
  # [:ignore_nil => true]   NilClass will not be listed                      (STANDARD)
  # [:ignore_nil => false]  NilClass will be listed  
  #
  # Tests and examples {TestKyaniteEnumerableStructure#test_contentclass_mono here}.
  #
  def contentclass( options={} )
    precision  = options[:precision]    || 2
    ignore_nil = options[:ignore_nil];  ignore_nil = true   if ignore_nil.nil?
    return nil   if  self.empty? 
    case precision
    
    when 1
      result = self.first.class
      if ( result == NilClass  &&  ignore_nil )
        return self.compact.contentclass( :precision => precision, :ignore_nil => false  )
      else
        return result
      end
      
    when 2
      f = self.first.class    
      l = self.last.class   
      if ( (f == NilClass || l == NilClass) &&  ignore_nil )
        return self.compact.contentclass( :precision => precision, :ignore_nil => false  )
      end      
      if f == l      
        return f
      else
        result = f.ancestors & l.ancestors
        #see result - [Object, Kernel, Precision, Perception::NumericI,  PP::ObjectMixin,  KKernel]
        return Numeric      if result.include?(Numeric)
        return Enumerable   if result.include?(Enumerable)
        return Object
      end
      
    when :all
      unless ( self.kind_of?(Hash) || self.kind_of?(Hashery::Dictionary) )
        c = self.collect {|e| e.class}
      else
        c = self.collect {| key, value | value.class}      
      end 
      c = c - [NilClass]  if ignore_nil
      c.uniq!  
      if c.empty? 
        return nil       if ignore_nil
        return NilClass   
      end
      return c[0]       if c.size == 1 
      result = c[0].ancestors
      c[1..-1].each do |e|
        result = result & e.ancestors
      end
      #see result - [Object, Kernel, Precision, Perception::NumericI,  PP::ObjectMixin,  KKernel]      
      return Numeric      if result.include?(Numeric)
      return Enumerable   if result.include?(Enumerable)
      return Object

    else # case precision
      raise ArgumentError, ':precision should be 1, 2 or :all'
    end #case
    
  end #def

end #module






# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 

  class Array
    include Enumerable
  end  


  test = [ 1,2,3]
  puts "Hallo"
  puts  test.contentclass(:precision => :all)

  

end



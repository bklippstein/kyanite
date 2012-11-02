# ruby encoding: utf-8
# 
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'facets/range/combine'
require 'facets/range/within'
require 'kyanite/enumerable'             # is_collection? ist false for Ranges




# @!macro range
#
# === Added from  {http://rubyworks.github.com/rubyfaux/?doc=http://rubyworks.github.com/facets/docs/facets-2.9.3/core.json#api-class-Range Facets Range}:  
# [+umbrella(range)+] Returns a two element array of the relationship between two Ranges
# [+within? (range)+] Is another Range anywhere within this Range?
# [+combine(range)+]  Combine ranges
#
class Range


  
  # Given a range for selecting a section of a {String} or an {Array},
  # +invert_index+ inverts this range, so that the result 
  # selects the inverse part of the {String} or {Array}. 
  #
  # @example 
  #  # return back 
  #  (0..5).invert_index
  #  => (6..-1)
  #   
  #  # return front 
  #  (3..-1).invert_index
  #  => (0..2)
  # 
  #  # return outer
  #  (2..4).invert_index
  #  => [0..1,   5..-1]
  #
  # Tests and more examples {TestKyaniteRange here}.
  #
  #
  # @return [Range] or [Array] of two Ranges
  def invert_index
  
    # back
    if first == 0
      return (1..0)           if last == -1     # leer
      return (last+1..-1)                       # hinterer Teil

    # front
    else 
      return (0..first-1)     if last == -1     # vorderer Teil
      
    end
    
    # outer
    return [(first..-1).invert_index, (0..last).invert_index]
  end # def

 
  
end # class
  
  
  

if defined? TransparentNil
  class NilClass
    # @!group return nil    
    def invert_index;                   nil;              end     
    def umbrella(*a);                   nil;              end     
    def combine(*a);                    nil;              end     
    def within?(*a);                    nil;              end     
  end
end # if defined? TransparentNil
    
    
    
# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 


  # puts TransparentNil::VERSION
  puts (nil.respond_to? :invert_index).inspect
 # puts nil.invert_index

  # test = [:a, :b, :c].to_ordered_set
  # see :test # .inspect_see
  # see_pp test
  # seee.process_print( test, :method => :pp )
  # see :test# .inspect_see

end  
    
    
    

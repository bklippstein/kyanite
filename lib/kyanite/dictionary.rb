# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'hashery' # old: 'facets/dictionary'
unless defined? ENUMERABLE_REQUIRED
  require 'kyanite/enumerable'             # is_collection? 
end





# @!macro dictionary
class Dictionary < Hashery::Dictionary

  def fetch_by_index(index)
    @hash[order[index]]
  end 
  
  def first_key
    order.first
  end
  
  def last_key
    order.last
  end  
  
  def -(other)
    (self.to_a - other.to_a).to_dictionary
  end
  
  def unshift( k,v )
    unless @hash.include?( k )
      @order.unshift( k )
      @hash.store( k,v )
      true
    else
      false
    end
  end
  
  
  def each_with_index
    order.each_with_index { |k,i| yield( k, @hash[k], i ) }
    self
  end
  
  
end




class Hash

  # @return [Dictionary]
  def to_dictionary
    result = Dictionary.new
      self.each do | key, value |
        result[key] = value
      end
    result
  end

end


class Array

  # @!group Cast
  # Returns {Dictionary} 
  # @return [Dictionary]  
  def to_dictionary
    # TODO: effizienter
    result = Dictionary.new
      self.each do | zeile |
        result << zeile
      end
    result
  end
  # @!endgroup   
  
  #funktioniert nicht
  # def to_dictionary2 # :nodoc:
    # Dictionary.new(self.flatten)
  # end  
  
end


if defined? TransparentNil
  class NilClass

    # Rückgabe: Leeres Dictionary    
    def to_dictionary;                      Dictionary.new;     end  

    def fetch_by_index(*a);                 nil;                end  

  end
end


# ---------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ 

  test = Dictionary[ 'a', 1, 'b', 2, 'c', 3 ]
  see test
  see
  see
  see test.order





end











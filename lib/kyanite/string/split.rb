# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


 require 'facets/string/shatter' 
 require 'kyanite/string/cast' 
 require 'kyanite/enumerable' 
 require 'kyanite/array/array'
 
 

class String

# ---------------------------------------------------------------------------------------------------------------------------------
# @!group Split
# See TestKyaniteStringSplit for tests and examples.
       


    # Returns _n_ characters of the string. If _n_ is positive
    # the characters are from the beginning of the string.
    # If _n_ is negative from the end of the string.
    #
    # Alternatively a replacement string can be given, which will
    # replace the _n_ characters. 
    # Example:
    #   'abcde'.nchar(1)  =>      'a'
    #   'abcde'.nchar(2)  =>      'ab'
    #   'abcde'.nchar(3)  =>      'abc'
    #   'abcde'.nchar(2,'')  =>   'cde'
    #
    # (The originaly version of this method is from the {http://rubyworks.github.com/rubyfaux/?doc=http://rubyworks.github.com/facets/docs/facets-2.9.3/core.json#api-class-String/api-method-String-h-nchar Facets} library).
    # See tests and examples {TestKyaniteStringSplit#test_nchar here}.  
    # @return [String] Substring
    def nchar(n, replacement=nil)
      if replacement
        return self   if n == 0     
        return ''     if (n.abs >= self.length)      
        s = self.dup
        n > 0 ? (s[0...n] = replacement) : (s[n..-1] = replacement)
        return s
        
      # ohne replacement  
      else
        return ''   if n == 0
        return self if (n.abs > self.length)
        n > 0 ? self[0...n] : self[n..-1]
      end
    end
    
    
    # Cuts a string to a maximal length. Example.:
    #   'Hello'.cut(3) => 'Hel'
    #   
    # See tests and examples {TestKyaniteStringSplit#test_cut here}.   
    # @return [String] Substring
    def cut(len=5)
        return '' if len <= 0
        self[0..len-1]
    end        
    
    
    # Forces a fixed size.
    #  
    # See tests and examples {TestKyaniteStringSplit#test_fixsize here}.  
    # @return [String]     
    def fixsize( len )
      return '' if len <= 0
      if self.size < len
        self.ljust(len)
      else
          self[0..len-1]
      end
    end    

    
    # Cuts a string in parts with given length.  
    # See tests and examples {TestKyaniteStringSplit#test_split_by_index here}.       
    # @param idx [Integer, Array of Integer] Length of parts 
    # @return [Array] All the parts with given length, plus remainder.
    def split_by_index(idx)     
      if idx.kind_of?(Integer)
       [nchar(idx)] + [nchar(idx,'')]
        
      elsif idx.kind_of?(Array)
       [nchar(idx[0])] + nchar(idx[0],'').split_by_index(idx.shift_complement)           
        
      end # if
    end
    
    
    
    # Extracts a substring using two regular expressions. Example:
    #   string = '<select id="hello"><option value="0">none</option></select>'
    #   string.extract(  /select.*?id="/  ,  '"'  )  =>  'hello'
    # 
    # See tests and examples {TestKyaniteStringSplit#test_extract here}.      
    # @return [String] Substring
    # @param start_regexp [RegExp, String] Start extraction here
    # @param stop_regexp [RegExp, String] Stop extraction here
    def extract( start_regexp, stop_regexp )
      split(start_regexp)[1].split(stop_regexp)[0]
    end    
        


        
    # Separates a string into numeric and alphanumeric parts.
    # Currently works only with positive integers. Example:
    #  'abc123'.split_numeric  >>  ['abc',123]   (Array)
    #  '123abc'.split_numeric  >>  [123,'abc']   (Array)
    #  '123'.split_numeric     >>  123           (Integer)
    #  'abc'.split_numeric     >>  'abc'         (String)
    #
    # It even works with more than two parts:
    #  '123abc456'.split_numeric  >>  [123,'abc',456]
    #  'abc123def'.split_numeric  >>  ['abc',123,'def']         
    #    
    # See tests and examples {TestKyaniteStringSplit#test_split_numeric here}.      
    # @return [Array] alphanumeric and numeric part
    #
    def split_numeric
        result = shatter(/\d+/).collect{ |i| i.to_integer_optional }
        return result[0]    if ( result.is_collection? && result.size == 1 )
        return result
    end
    


    # Removes numeric parts and trailing white spaces, hyphens, underscores, and periods.   
    # See tests and examples {TestKyaniteStringSplit#test_without_versioninfo here}.      
    # @return [String] Substring  
    def without_versioninfo
        shatter(/\d+/)[0].strip.chomp('_').chomp('-').chomp('.')
    end        
    
end

# @!endgroup

class NilClass

  # Rückgabe: Leerer String,
  # siehe String#split
  def cut(*a);                            '';             end  
  
  def nchar(*a);                          nil;            end  
  def split_by_index(*a);                 nil;            end  
  def extract(*a);                        nil;            end  
  def split_numeric;                      nil;            end  
  def without_versioninfo;                nil;            end    
end



class Numeric


  # +self+, complements {String#split_numeric}. 
  # @return [Numeric]
  def split_numeric 
      self 
  end    

  
  
end  














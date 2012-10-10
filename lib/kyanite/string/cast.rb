# ruby encoding: utf-8
require 'kyanite/numeric/integer'
 
# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | Object | *String* | Symbol | Numeric |
#
# ---
#
# == *String*  
#
#
class String

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Cast
  # See TestKyaniteStringCast for tests and examples.
  #  

    
    
    # Wandelt einen String in den plausibelsten Identifier um:
    #   self.strip.to_integer_optional
    #
    # Tests & Beispiele siehe TestKyaniteStringCast#test_to_identifier
    def to_identifier
      self.strip.to_integer_optional
    end        
        
        
    # Wandelt einen String in einen Integer, auch dann, wenn die Zahl hinten angehängt wurde.
    # Im Gegensatz zu to_i wird nil zurückgegeben, wenn keine Zahl drin war. 
    # 
    # Beispiele & Tests siehe TestKyaniteStringCast#test_to_integer      
    def to_integer
        return nil                 unless self =~ /\d/
        firsttry = self.to_i
        return firsttry         if firsttry != 0
        return self.scan(/\d+/)[0].to_i 
    end


    # Wandelt einen String in einen Integer.
    # Im Gegensatz zu to_i wird self zurückgegeben, wenn der String nicht mit einer Zahl beginnt.
    # Leere Strings werden in NIL umgewandelt. 
    # 
    # Beispiele & Tests siehe TestKyaniteStringCast#test_to_integer_optional    
    def to_integer_optional
        return nil                  if self.empty?
        return self                 unless (self =~ /^\d/  || self =~ /^-\d/ )
        return self.to_i
    end
    

    def to_nil
      return self unless self.empty?
      nil
    end    
        
        

 
    unless defined? HEX_CHARS
      HEX_CHARS = '0123456789abcdef'.freeze
    end

    
    # Get a hex representation for a char.
    # See also String#from_x.     
    def to_x
      hex = ''
      each_byte { |byte|
        # To get a hex representation for a char we just utilize
        # the quotient and the remainder of division by base 16.
        q, r = byte.divmod(16)
        hex << HEX_CHARS[q] << HEX_CHARS[r]
      }
      hex
    end
    
    # Get a char for a hex representation.   
    # See also String#to_x. 
    def from_x
      str, q, first = '', 0, false
      each_byte { |byte|
        # Our hex chars are 2 bytes wide, so we have to keep track
        # of whether it's the first or the second of the two.
        #
        # NOTE: inject with each_slice(2) would be a natural fit,
        # but it's kind of slow...
        if first = !first
          q = HEX_CHARS.index(byte)
        else
          # Now we got both parts, so let's do the
          # inverse of divmod(16): q * 16 + r
          str << q * 16 + HEX_CHARS.index(byte)
        end
      }
      str
    end
    

end


class NilClass
  def to_identifier;                  nil;            end
  def to_integer;                     nil;            end
  def to_integer_optional;            nil;            end
  def to_nil(*a);                     nil;            end  
  def to_x;                           nil;            end  
  def from_x;                         nil;            end  
end





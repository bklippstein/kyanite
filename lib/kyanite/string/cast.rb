# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
  require 'perception'  
end

require 'kyanite/numeric/integer'
 

class String

  
  # @!group Cast
  
    # reverse of {Array#to_s_utf8}
    # @return [Array]
    #
    def to_array_of_codepoints
      self.codepoints.to_a
    end  
  
  
    # Converts a string into the most plausible Identifier
    #
    # See examples and tests {TestKyaniteStringCast#test_to_identifier here}.     
    # @return [Integer]        
    def to_identifier
      self.strip.to_integer_optional
    end        
        
        
    
    # Converts a string to an integer, even if the number was appended to anything.
    # Unlike +to_i+ it returns +nil+ if no integer was found inside the string.    
    # 
    # See examples and tests {TestKyaniteStringCast#test_to_integer here}.      
    # @return [Integer]     
    def to_integer
        return nil                 unless self =~ /\d/
        firsttry = self.to_i
        return firsttry         if firsttry != 0
        return self.scan(/\d+/)[0].to_i 
    end


    
    # Tries to convert a string to an integer. 
    # Returns +self+ if the string does not start with a number.
    # Empty strings are converted to +nil+.
    #
    # See examples and tests {TestKyaniteStringCast#test_to_integer_optional here}.   
    # @return [Integer, String]
    def to_integer_optional
        return nil                  if self.empty?
        return self                 unless (self =~ /^\d/  || self =~ /^-\d/ )
        return self.to_i
    end
    
    
    # Non-empty strings are returned.
    # Empty strings are converted to +nil+.
    # @return [String, Nil]    
    def to_nil
      return self unless self.empty?
      nil
    end    
        
        

 
    unless defined? HEX_CHARS
      # @private
      HEX_CHARS = '0123456789abcdef'.freeze
    end

    
    # Get a hex representation for a char.
    # See also {#from_x from_x}.     
    # @return [String]       
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
    # See also {#to_x to_x}.     
    # @return [String]       
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
    
    
    unless defined? MYSQL_REPLACES
      MYSQL_REPLACES =  [                 
                                          [/ä/,    'a'], 
                                          [/ö/,    'o'],  
                                          [/ü/,    'u'],        
                                          [/Ä/,    'a'], 
                                          [/Ö/,    'o'],  
                                          [/Ü/,    'u'],      
                                          [/ss/,   'ß'],      
                                          [/SS/,   'ß']     
                        ]  
    end      
    
    
    # Converts a string so that you can recognize with utf8_general_ci compared strings
    #   
    def mysqlize
      self.tidy_bytes.mgsub(MYSQL_REPLACES).downcase.to_s
    end        
    

end


# @!endgroup

class NilClass
  def to_identifier;                  nil;            end
  def to_integer;                     nil;            end
  def to_integer_optional;            nil;            end
  def to_nil(*a);                     nil;            end  
  def to_x;                           nil;            end  
  def from_x;                         nil;            end  
end


class Integer
  
  
  # +self+, complements {String#to_integer}. 
  # @return [self]
  def to_integer;                     self;            end     
  
  
  # +self+, complements {String#to_integer_optional}. 
  # @return [self] 
  def to_integer_optional;            self;            end  
      
  
end # class



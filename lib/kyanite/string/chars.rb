# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


require 'kyanite/string/chars_const' unless defined? TR_FULL
require 'kyanite/string/misc'
require 'unicode_utils/nfkd'



class String

  

    # ---------------------------------------------------------------------------------------------------------------------------------
    # @!group Clear / Format Text
    # See TestKyaniteStringChars for tests and examples.    
    
    
    # reverse of {Array#to_s_utf8}
    # @return [Array]
    #
    def to_a
      result = []
      self.each_char do |c|
      result << c
      end
      result
    end      
    
    # reverse of {Array#to_s_utf8}
    # @return [Array]
    #
    def to_array_of_codepoints
      self.codepoints.to_a
    end  
    
    # @return [Array]    
    def to_array_of_hex
      self.unpack('U'*self.length).collect {|x| x.to_s 16}
    end    
    
    
    # Reduces a rich unicode string to a very limited character set like humans do. Example:
    #  "Céline hören".reduce
    #  => "Celine hoeren"
    #
    # Handles all characters from ISO/IEC 8859-1 and CP1252
    # like humans do, not just deleting the accents. 
    # So it's not a 1:1 translation, some unicode characters are translated to 
    # multible characters. Example:
    #  "ÄÖÜäöüß".reduce
    #  => "AeOeUeaeoeuess"    
    #
    # For many unicode characters, this behaviour is based on +UnicodeUtils.nfkd+. Example:
    #  ffi = "\uFB03"
    #  ix = "\u2168"
    #  high23="²³"
    #  high5 = "\u2075"
    #  all = ffi + ix + high23 + high5 
    #  all.reduce
    #  => "ffiIX235"
    # 
    # You can preserve some characters, e.g. all special characters of a specific language. Example:
    #  "Céline hören 10€".reduce( :preserve => "ÄÖÜäöüß")
    #  => "Celine hören 10EUR"
    #
    # Newlines are preserved by default, but all other nonprintable ascii characters below \\x20 are removed.
    #
    # There is also a fast mode. It's about 10 times faster, but it supports only 1:1 translation.
    #  "Céline hören 10€".reduce( :preserve => "ÄÖÜäöüß€", :fast => true )
    #  => "Celine hören 10€"   
    #
    #  "ÄÖÜäöüß€".reduce( :fast => true ) 
    #  => "AOUaous"        
    # 
    # Your result will only contain these characters:
    # * printable letters and basic symbols of the 7bit ASCII charset (\\x20..\\x7e)
    # * preserved characters as defined in the options (max 18)
    # * newlines (\\x0a and \\x0d)
    # 
    # Options:
    # [:preserve] Special characters to preserve. You can only preserve up to 18 characters.
    # [:fast]     Fast mode, if true. About 10 times faster, but it supports only 1:1 translation.
    # 
    # @return [String]
    def reduce( options ={} )
      preserve = options[:preserve] || ''
      raise ArgumentError, 'max preserve string length is 18 chars'   if preserve.length > 18 
      
      result = self.delete("\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0b\x0c\x0e-\x1f") 
      result.tr!(preserve, "\x0e-\x1f")                               if preserve.length > 0
      
      result = result.to_ascii_extra_chars                            unless options[:fast]
      result.tr!(TR_FULL, TR_REDUCED)     
      result = UnicodeUtils.nfkd(result)                              unless options[:fast]
      
      result.delete!("^\x09-\x7e")          
      result.tr!("\x0e-\x1f", preserve)                               if preserve.length > 0    
      result
    end     
    
    

    # @deprecated
    # @return [String]
    def reduce94( options={} )
      reduce(  {:fast => true}.merge(options)  )
    end        
    


    
    # Reduziert den String auf ein Base53-Encoding, 
    # bestehend aus Großbuchstaben, Minuszeichen und zu Kleinbuchstaben umgeformten Sonderzeichen.
    # Alle reduzierten Zeichen sind aber *klein*, streng genommen handelt es sich also um ein Base52-Encoding.
    # Wandelt z.B. àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰ usw. in aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa usw. um. 
    #       
    # See TestKyaniteStringChars for tests and examples.
    #    
    
    # Reduces the string to a base53 encoding.
    # The result consists only uppercase letters, minus, and lowercase characters as replacement for some known special characters.
    # 1. Removes all non-letter-chars.
    # 2. Converts all regular letters to upcase letters. 
    # 3. Converts special letters to reduced downcase letters, eg. àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰ etc. to aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.
    # 4. Caution: Also Newlines are removed. 
    #   
    # See tests and examples {TestKyaniteStringChars#test_reduce53_a here}.
    # @return [String]
    def reduce53( options={} )
      dup.reduce53!(options)
    end        
    
    
    # In-place-variant of {#reduce53 reduce53}.
    # @return [String]    
    def reduce53!( options={} )
    
      if options[:camelcase]  
        self.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1-\2')
        self.gsub!(/([a-z\d])([A-Z])/,'\1-\2')
      end
      
      self.gsub!( 'ß', options[:german_sz] )        if options[:german_sz]        
      self.tr!('abcdefghijklmnopqrstuvwxyz§', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ') 
      
      self.tr!(TR_FULL, TR_REDUCED.downcase)  
      unless options[:space]
        self.delete!('^- A-Za-z')
      else
        self.tr!('^- A-Za-z', ' ')      
      end
      self.gsub!(/-+/,  ' ')          
      self.gsub!(/\s+/, ' ')      
      self.strip!   
      self.gsub!(/ /,   '-')           
      self
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
      self.mgsub(MYSQL_REPLACES).downcase.to_s
    end            
    

    
    # macht die nötigen Korrekturen für EmailAddress und Domain.
    #
    # Tests & Beispiele siehe TestKyaniteStringChars 
    # def strip_downcase_iconv
                #to          #from 
      # Iconv.new('iso-8859-1','utf-8').iconv(self.strip.downcase2)
    # rescue
      # self.strip.downcase2
    # end    
    
    
    
    # ---------------------------------------------------------------------------------------------------------------------------------
    # @!group Upcase and Downcase with support for special letters like german umlauts
    # See TestKyaniteStringChars for tests and examples.
    #
    
    # Better +downcase+: also works with special letters like german umlauts.
    # (If you overwrite downcase you will get strange results if you use Active Support.)
    #
    # See tests and examples {TestKyaniteStringChars#test_downcase_upcase here}.  
    # @return [String]    
    def downcase2 
      self.tr(TR_UPCASE, TR_DOWNCASE).downcase
    end    
    
    # In-place-variant of {#downcase2 downcase2}.    
    # @return [String]    
    def downcase2! 
      self.tr!(TR_UPCASE, TR_DOWNCASE).downcase!
    end        
    
    
    # Better +upcase+: also works with special letters like german umlauts.
    # (If you overwrite upcase you will get strange results if you use Active Support.)    
    #
    # See tests and examples {TestKyaniteStringChars#test_downcase_upcase here}.      
    # @return [String]      
    def upcase2
      self.tr(TR_DOWNCASE, TR_UPCASE).upcase
    end      
    
    # In-place-variant of {#upcase2 upcase2}.    
    # @return [String]    
    def upcase2!
      self.tr!(TR_DOWNCASE, TR_UPCASE).upcase!
    end  

    # Converts the first letter to upcase, also works with special letters like german umlauts.
    # @return [String]      
    def capitalize
      (slice(0) || '').upcase2 + (slice(1..-1) || '').downcase2
    end
    
    
    # Is the first letter upcase? Also works with special letters like german umlauts. 
    def capitalized?
      self =~ TR_UPCASE_ALL_REGEXP
    end   

    # Is the string upcase? Also works with special letters like german umlauts.    
    def upcase?
      (self == self.upcase2)
    end
    
    # Is the string downcase? Also works with special letters like german umlauts.     
    def downcase?
      (self == self.upcase2)
    end    

end

class Array    

  # reverse of {String#to_array_of_codepoints}
  # @return [String]
  #  
  def to_s_utf8
    self.pack("U*").encode('utf-8')
  end
  
end


if defined? TransparentNil
  class NilClass

    # Rückgabe: false
    def capitalized?;                 false;          end  
    
    def reduce94;                     nil;            end
    def reduce94!;                    nil;            end
    def reduce53;                     nil;            end
    def reduce53!;                    nil;            end  
    def downcase2;                    nil;            end    
    def downcase2!;                   nil;            end    
    def mysqlize;                     nil;            end  
    def upcase2;                      nil;            end  
    def upcase2!;                     nil;            end  
  end
end

# -----------------------------------------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ then

  #require 'perception'
  
  #puts "Hallo"
  # puts 'Scheiße'.reduce94(:german_sz => 'z')
  # test_down =       'àáâăäãāåạąæảấầắằабćĉčçċцчďðđдèéêěĕëēėęếеэфĝğġģгĥħхìíîĭïĩīıįĳийĵюяķкĺľłļŀлмńňñņŋнòóôŏöõōøőơœопŕřŗрśŝšşсшщţťŧþтùúûŭüũūůűųưувŵýŷÿźżžжз'
  # test_up =         'ÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰАБĆĈČÇĊЦЧĎÐĐДÈÉÊĚĔËĒĖĘẾЕЭФĜĞĠĢГĤĦХÌÍÎĬÏĨĪİĮĲИЙĴЮЯĶКĹĽŁĻĿЛМŃŇÑŅŊНÒÓÔŎÖÕŌØŐƠŒОПŔŘŖРŚŜŠŞСШЩŢŤŦÞТÙÚÛŬÜŨŪŮŰŲƯУВŴÝŶŸŹŻŽЖЗ'

  # puts "hallo".upcase!

    full    = 'àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰ'
    reduced = 'aaaaaaaaaaaaaaaaAAAAAAAAAAAAAAAA'   

    full.each_char do |c|
      puts c.noaccents
    end  

end




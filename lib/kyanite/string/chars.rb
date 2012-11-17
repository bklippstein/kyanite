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
    
    
    # Reduces the string to a ASCII encoding. Example:
    #  ffi = "\uFB03"
    #  ix = "\u2168"
    #  high23="²³"
    #  high5 = "\u2075"
    #  all = ffi + ix + high23 + high5 
    #  all.to_ascii
    #  => "ffiIX235"
    # 
    # Based on +UnicodeUtils.nfkd+, but handles all characters from ISO/IEC 8859-1 and CP1252
    # like humans do, not just deleting the accents. Example:
    #  "ÄÖÜäöüß".to_ascii
    #  => "AeOeUeaeoeuess"
    #
    # 1. Converts ÄÖÜäöüßàáâăäãāåạąæảấầắằ etc. to AeOeUeaeoeuessaaaaaaaaaaaaaaaa.
    # 2. Then removes all non-Ascii-chars.
    # 3. Then removes all non-printable Ascii-chars.
    # 4. Caution: Also Newlines are removed.    
    # About 10 times slower than {#reduce94 reduce94}, but more accurate.     
    # 
    def to_ascii
      result = self.to_ascii_extra_chars 
      result.tr!(TR_FULL, TR_REDUCED)     # not necessary, only for performance 
      return UnicodeUtils.nfkd(result).delete('^ -~') # delete is faster than gsub
    end     
    
    

    # Reduces the string to a base94 encoding.
    # About 10 times faster than with +UnicodeUtils+.     
    # 1. Converts àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰ etc. to aaaaaaaaaaaaaaaaAAAAAAAAAAAAAAAA.
    # 2. Then removes all non-Ascii-chars.
    # 3. Then removes all non-printable Ascii-chars.
    # 4. Caution: Also Newlines are removed. 
    #   
    # See tests and examples {TestKyaniteStringChars#test_reduce94_a here}.
    # @return [String]
    def reduce94( options={} )
      dup.reduce94!(options)
    end        
    

    # In-place-variant of {#reduce94 reduce94}.   
    # @return [String]
    def reduce94!( options={} )       
      self.gsub!( 'ß', options[:german_sz] )        if options[:german_sz]      
      self.tr!(TR_FULL, TR_REDUCED)
      self.delete!('^ -~')
      self
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
      (self == self.upcase)
    end
    
    # Is the string downcase? Also works with special letters like german umlauts.     
    def downcase?
      (self == self.upcase)
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




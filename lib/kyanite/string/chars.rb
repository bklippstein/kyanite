# ruby encoding: utf-8
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/string/chars_const'

  
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
    
    
   
   


class String

    # ---------------------------------------------------------------------------------------------------------------------------------
    # :section: Clear / Format Text
    # See TestKyaniteStringChars for tests and examples.    

    # Reduziert den String auf ein Base94-Encoding.
    # * Wandelt àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰ usw. in aaaaaaaaaaaaaaaaAAAAAAAAAAAAAAAA usw. um 
    # * entfernt anschließend alle Nicht-Asciizeichen
    # * entfernt außerdem alle nichtdruckbaren Asciizeichen
    # * Vorsicht: Newlines werden auch entfernt
    #   
    # See TestKyaniteStringChars for tests and examples.
    #
    def reduce94( options={} )
      dup.reduce94!(options)
    end        
    
    # See TestKyaniteStringChars for tests and examples.
    #    
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
    def reduce53( options={} )
      dup.reduce53!(options)
    end        
    
    # See TestKyaniteStringChars for tests and examples.
    #    
    def reduce53!( options={} )
    
      if options[:camelcase]  
        self.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1-\2')
        self.gsub!(/([a-z\d])([A-Z])/,'\1-\2')
      end
      
      self.gsub!( 'ß', options[:german_sz] )        if options[:german_sz]        
      self.tr!('abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') 
      
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
    
    

    
    # Formt einen String so um, dass man auch mit utf8_general_ci verglichene Strings wiedererkennen kann
    #
    # See TestKyaniteStringChars for tests and examples.
    #   
    # def mysqlize
      # self.tidy_bytes.mgsub(MYSQL_REPLACES).downcase.to_s
    # end           
    

    
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
    # :section: Groß- und Kleinschreibung
    # See TestKyaniteStringChars for tests and examples.
    #
    
    # Ein Überschreiben von downcase führt in Kombination mit ActiveSupport zu seltsamen Ergebnissen!
    def downcase2 
      self.tr(TR_UPCASE, TR_DOWNCASE).downcase
    end    
    
    def downcase2! 
      self.tr!(TR_UPCASE, TR_DOWNCASE).downcase!
    end        
    
    
    # Ein Überschreiben von upcase führt in Kombination mit ActiveSupport zu seltsamen Ergebnissen!       
    def upcase2
      self.tr(TR_DOWNCASE, TR_UPCASE).upcase
    end      
    
    def upcase2!
      self.tr!(TR_DOWNCASE, TR_UPCASE).upcase!
    end  

    def capitalize
      (slice(0) || '').upcase2 + (slice(1..-1) || '').downcase2
    end
    
    
    # Erster Buchstabe groß?
    def capitalized?
      self =~ TR_UPCASE_ALL_REGEXP
    end   

    def upcase?
      (self == self.upcase)
    end
    
    def downcase?
      (self == self.upcase)
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
  puts 'Scheiße'.reduce94(:german_sz => 'z')



end




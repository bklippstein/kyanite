# ruby encoding: utf-8 

 require 'facets/string/shatter' 
 require 'kyanite/string/cast' 
 require 'kyanite/enumerable' 
 require 'kyanite/array/array'
 
 

class String

# ---------------------------------------------------------------------------------------------------------------------------------
# :section: Split
# See TestKyaniteStringSplit for tests and examples.
#
# Aus {Facets/String}[http://facets.rubyforge.org/doc/api/core/classes/String.html]eingefügt:
# *shatter*(re) 
# Breaks a string up into an array based on a regular expression. Similar to +scan+, but includes the matches.       


    
    # Returns _n_ characters of the string. If _n_ is positive
    # the characters are from the beginning of the string.
    # If _n_ is negative from the end of the string.
    #
    # Alternatively a replacement string can be given, which will
    # replace the _n_ characters. 
    # Example:
    #   'abcde'.nchar(2)  =>      'ab'
    #   'abcde'.nchar(2,'')  =>   'cde'
    #
    # NICHT die Version aus Facets verwenden!!!
    # Tests siehe TestKyaniteStringSplit#test_nchar   
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
    
    
    # Schneidet eine String auf eine Maximallänge. Bsp.:
    #   'Hallo'.cut(3) => 'Hal'
    # 
    # Tests siehe TestKyaniteStringSplit#test_cut    
    def cut(len=5)
        return '' if len <= 0
        self[0..len-1]
    end        
    
    
    # Erzwingt eine bestimmte Länge
    # 
    # Tests siehe TestKyaniteStringSplit#test_fixsize        
    def fixsize( len )
      return '' if len <= 0
      if self.size < len
        self.ljust(len)
      else
          self[0..len-1]
      end
    end    

    
    # Schneidet einen String in Stücke. 
    # Wie lang die Stücke sind, sagt der Parameter (Format: einzelner Integer oder Array of Integer).
    # Gibt alle Stücke zurück plus den Rest, der übrigbleibt.
    # 
    # Beispiele & Tests siehe TestKyaniteStringSplit#test_split_by_index      
    def split_by_index(idx)     
      if idx.kind_of?(Integer)
       [nchar(idx)] + [nchar(idx,'')]
        
      elsif idx.kind_of?(Array)
       [nchar(idx[0])] + nchar(idx[0],'').split_by_index(idx.shift_complement)           
        
      end # if
    end
    
    
    
    # Extrahiert einen Teilstring anhand zweier regulärer Ausdrücke. Beispiel:
    #   string = '<select id="hallo"><option value="0">none</option></select>'
    #   string.extract(/select.*?id="/,'"')  =>  'hallo'
    #
    def extract( start_regexp, stop_regexp )
      split(start_regexp)[1].split(stop_regexp)[0]
    end    
        


        
    # Trennt einen String in numerische und alphanumerische Teile auf.
    # Funktioniert derzeit nur mit positiven Integers. Bsp.:
    #  'abc123'.split_numeric  >>  ['abc',123]   (Array)
    #  '123abc'.split_numeric  >>  [123,'abc']   (Array)
    #  '123'.split_numeric     >>  123           (Integer)
    #  'abc'.split_numeric     >>  'abc'         (String)
    #
    # Das funktioniert sogar mit mehr als zwei Teilen:
    #  '123abc456'.split_numeric  >>  [123,'abc',456]
    #  'abc123def'.split_numeric  >>  ['abc',123,'def']         
    #
    # Tests siehe TestKyaniteStringSplit#test_split_numeric
    def split_numeric
        result = shatter(/\d+/).collect{ |i| i.to_integer_optional }
        return result[0]    if ( result.is_collection? && result.size == 1 )
        return result
    end
    

    # Trennt numerische Teile ab und entfernt abschließende Whitespaces, Bindestriche, Unterstriche und Punkte.
    # Wird z.B. für die Generierung des Doku-Pfades verwendet. 
    #
    # Tests siehe TestKyaniteStringSplit
    def without_versioninfo
        shatter(/\d+/)[0].strip.chomp('_').chomp('-').chomp('.')
    end        
    
end


if defined? TransparentNil
  class NilClass

    # Rückgabe: Leerer String,
    # siehe String#split
    def cut(*a);                            '';             end  
    
    def nchar(*a);                          nil;            end  
    def split_by_index(*a);                 nil;            end  
    def extract(*a);                        nil;            end  
    def split_numeric;                      nil;            end  
    def without_versioninfo;          nil;            end    
  end
end
